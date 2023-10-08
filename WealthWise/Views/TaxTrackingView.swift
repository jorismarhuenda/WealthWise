//
//  TaxTrackingView.swift
//  WealthWise
//
//  Created by marhuenda joris on 05/09/2023.
//

import SwiftUI
import Firebase
import MobileCoreServices
import FirebaseStorage

class DocumentPickerDelegate: NSObject, ObservableObject, UIDocumentPickerDelegate {
    @Published var selectedPDFURL: URL?

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedURL = urls.first {
            self.selectedPDFURL = selectedURL
        }
    }
}

struct TaxTrackingView: View {
    @StateObject private var documentPickerDelegate = DocumentPickerDelegate()
    @State private var taxPayments: [TaxPayment] = []
    @State private var newTaxPaymentName: String = ""
    @State private var newTaxPaymentAmount: String = ""

    private var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }

    var body: some View {
        VStack {
            Text("Suivi des Impôts")
                .font(.title)
                .padding()

            List {
                ForEach(taxPayments) { taxPayment in
                    TaxPaymentRowView(taxPayment: taxPayment)
                }
                .onDelete(perform: deleteTaxPayment)
            }

            HStack {
                TextField("Nom de l'impôt", text: $newTaxPaymentName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Montant", text: $newTaxPaymentAmount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()

                Button(action: {
                    importDocument()
                }) {
                    Text("Importer PDF")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                if let pdfURL = documentPickerDelegate.selectedPDFURL {
                    Text("PDF: \(pdfURL.lastPathComponent)")
                        .foregroundColor(.green)
                        .font(.footnote)
                        .padding()
                }

                Button(action: addTaxPayment) {
                    Text("Ajouter")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear(perform: fetchTaxPayments)
    }

    func addTaxPayment() {
        guard let currentUserID = currentUserID,
              let amount = Double(newTaxPaymentAmount) else {
            return
        }

        let newTaxPayment = TaxPayment(id: UUID().uuidString, name: newTaxPaymentName, amount: amount, userId: currentUserID)

        let db = Firestore.firestore()
        let taxPaymentsRef = db.collection("taxPayments")

        let taxPaymentData: [String: Any] = [
            "name": newTaxPayment.name,
            "amount": newTaxPayment.amount,
            "userId": newTaxPayment.userId
        ]

        taxPaymentsRef.addDocument(data: taxPaymentData) { error in
            if let error = error {
                print("Erreur lors de l'ajout de l'impôt : \(error.localizedDescription)")
            } else {
                fetchTaxPayments()
                newTaxPaymentName = ""
                newTaxPaymentAmount = ""
            }
        }

        if let selectedPDFURL = documentPickerDelegate.selectedPDFURL {
            uploadPDF(pdfURL: selectedPDFURL, taxPaymentID: newTaxPayment.id)
        }
    }

    func fetchTaxPayments() {
        guard let currentUserID = currentUserID else {
            return
        }

        let db = Firestore.firestore()
        let taxPaymentsRef = db.collection("taxPayments")

        taxPaymentsRef
            .whereField("userId", isEqualTo: currentUserID)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Erreur lors de la récupération des impôts : \(error.localizedDescription)")
                } else if let documents = querySnapshot?.documents {
                    let taxPayments: [TaxPayment] = documents.compactMap { document in
                        let data = document.data()
                        if let name = data["name"] as? String,
                           let amount = data["amount"] as? Double {
                            return TaxPayment(id: document.documentID, name: name, amount: amount, userId: currentUserID)
                        } else {
                            return nil
                        }
                    }
                    self.taxPayments = taxPayments
                }
            }
    }

    func deleteTaxPayment(at offsets: IndexSet) {
        guard let currentUserID = currentUserID else {
            return
        }

        let db = Firestore.firestore()
        let taxPaymentsRef = db.collection("taxPayments")

        offsets.forEach { offset in
            let taxPaymentToDelete = taxPayments[offset]

            taxPaymentsRef
                .whereField("id", isEqualTo: taxPaymentToDelete.id)
                .whereField("userId", isEqualTo: currentUserID)
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        print("Erreur lors de la suppression de l'impôt : \(error.localizedDescription)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete { error in
                                if let error = error {
                                    print("Erreur lors de la suppression de l'impôt : \(error.localizedDescription)")
                                } else {
                                    if let index = self.taxPayments.firstIndex(where: { $0.id == taxPaymentToDelete.id }) {
                                        self.taxPayments.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                }
        }
    }

    func uploadPDF(pdfURL: URL, taxPaymentID: String) {
        guard let currentUserID = currentUserID else {
            return
        }

        let storage = Storage.storage()
        let storageRef = storage.reference()

        let taxPaymentRef = storageRef.child("taxPayments/\(currentUserID)/\(taxPaymentID).pdf")

        taxPaymentRef.putFile(from: pdfURL, metadata: nil) { metadata, error in
            guard let _ = metadata else {
                print("Erreur lors du chargement du fichier PDF : \(error?.localizedDescription ?? "Erreur inconnue")")
                return
            }

            taxPaymentRef.downloadURL { url, error in
                if let url = url {
                    print("URL du PDF téléchargé : \(url)")

                    self.documentPickerDelegate.selectedPDFURL = nil
                    fetchTaxPayments()
                } else {
                    print("Erreur lors de l'obtention de l'URL du PDF : \(error?.localizedDescription ?? "Erreur inconnue")")
                }
            }
        }
    }
    
    func importDocument() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        documentPicker.delegate = documentPickerDelegate
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
    }
}

struct TaxPaymentRowView: View {
    let taxPayment: TaxPayment

    var body: some View {
        HStack {
            Text(taxPayment.name)
            Spacer()
            Text("\(taxPayment.amount, specifier: "%.2f") €")
        }
    }
}

struct TaxPayment: Identifiable {
    var id: String
    var name: String
    var amount: Double
    var userId: String
}

struct TaxTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TaxTrackingView()
    }
}
