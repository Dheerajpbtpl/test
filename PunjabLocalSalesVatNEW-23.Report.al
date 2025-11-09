// Report 50033 "Punjab Local Sales Vat NEW-23"
// {
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/PunjabLocalSalesVatNEW-23.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = order(ascending) where("Source Type" = filter(Customer), "Tax Type" = filter(VAT), "Location Code" = filter('*LDH*'));
//             column(FormCode_DetailedTaxEntry; "Detailed Tax Entry"."Form Code")
//             {
//             }
//             column(TransactionType_DetailedTaxEntry; "Detailed Tax Entry"."Transaction Type")
//             {
//             }
//             column(DocumentType_DetailedTaxEntry; "Detailed Tax Entry"."Document Type")
//             {
//             }
//             column(DocumentNo_DetailedTaxEntry; "Detailed Tax Entry"."Document No.")
//             {
//             }
//             column(PostingDate_DetailedTaxEntry; Format("Detailed Tax Entry"."Posting Date"))
//             {
//             }
//             column(Type_DetailedTaxEntry; "Detailed Tax Entry".Type)
//             {
//             }
//             column(ProductType_DetailedTaxEntry; "Detailed Tax Entry"."Product Type")
//             {
//             }
//             column(SourceType_DetailedTaxEntry; "Detailed Tax Entry"."Source Type")
//             {
//             }
//             column(SourceNo_DetailedTaxEntry; "Detailed Tax Entry"."Source No.")
//             {
//             }
//             column(TaxBaseAmount_DetailedTaxEntry; "Detailed Tax Entry"."Tax Base Amount")
//             {
//             }
//             column(Tax_DetailedTaxEntry; "Detailed Tax Entry"."Tax %")
//             {
//             }
//             column(TaxAmount_DetailedTaxEntry; "Detailed Tax Entry"."Tax Amount")
//             {
//             }
//             column(StateCode_DetailedTaxEntry; "Detailed Tax Entry"."State Code")
//             {
//             }
//             column(LocationCode_DetailedTaxEntry; "Detailed Tax Entry"."Location Code")
//             {
//             }
//             column(PurchTax_DetailedTaxEntry; "Detailed Tax Entry"."Purch. Tax %")
//             {
//             }
//             column(TaxAreaCode_DetailedTaxEntry; "Detailed Tax Entry"."Tax Area Code")
//             {
//             }
//             column(Quantity_DetailedTaxEntry; "Detailed Tax Entry".Quantity)
//             {
//             }
//             column(GLAccountNo_DetailedTaxEntry; "Detailed Tax Entry"."G/L Account No.")
//             {
//             }
//             column(PurchSalesAccountNo_DetailedTaxEntry; "Detailed Tax Entry"."Purch./Sales Account No.")
//             {
//             }
//             column(TaxGroupCode_DetailedTaxEntry; "Detailed Tax Entry"."Tax Group Code")
//             {
//             }
//             column(ItemLedgerEntryNo_DetailedTaxEntry; "Detailed Tax Entry"."Item Ledger Entry No.")
//             {
//             }
//             column(TaxType_DetailedTaxEntry; "Detailed Tax Entry"."Tax Type")
//             {
//             }
//             column(PurchTaxAmount_DetailedTaxEntry; "Detailed Tax Entry"."Purch. Tax Amount")
//             {
//             }
//             column(BearerName; BearerName)
//             {
//             }
//             column(TIN; "TIN No.")
//             {
//             }
//             column(TaxAmtC; TaxAmtC)
//             {
//             }
//             column(TaxAmt; TaxAmt)
//             {
//             }
//             column(TaxAmtVAT; TaxAmtVAT)
//             {
//             }
//             column(AmtVAT; AmtVAT)
//             {
//             }
//             column(AmtVATTot; AmtVATTot)
//             {
//             }
//             column(Sno; Sno)
//             {
//             }
//             trigger OnPreDataItem();
//             begin
//                 Sno := 0;
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 Sno += 1;
//                 TaxAmt := 0;
//                 TaxAmtC := 0;
//                 TaxAmtVAT := 0;
//                 if "Detailed Tax Entry"."Tax Type" = "Detailed Tax Entry"."tax type"::CST then begin
//                     if "Detailed Tax Entry"."Form Code" = 'C' then begin
//                         TaxAmtC := "Detailed Tax Entry"."Tax Base Amount";
//                         //meaasge(TaxAmt);
//                     end else
//                         TaxAmt := "Detailed Tax Entry"."Tax Base Amount";
//                 end else
//                     if "Detailed Tax Entry"."Tax Type" = "Detailed Tax Entry"."tax type"::VAT then begin
//                         TaxAmtVAT := "Detailed Tax Entry"."Tax Base Amount";
//                         AmtVAT := "Detailed Tax Entry"."Tax Amount";
//                         AmtVATTot := TaxAmtVAT + AmtVAT;
//                     end;
//                 "TIN No." := '';
//                 BearerName := '';
//                 if "Detailed Tax Entry"."Source Type" = "Detailed Tax Entry"."source type"::Customer then begin
//                     Customer.Get("Detailed Tax Entry"."Source No.");
//                     BearerName := Customer.Name;
//                     "TIN No." := Customer."T.I.N. No.";
//                 end;
//                 /*IF "Detailed Tax Entry"."Source Type" = "Detailed Tax Entry"."Source Type"::Vendor THEN BEGIN
// 				vendor.GET("Detailed Tax Entry"."Source No.");
// 				BearerName:=vendor.Name;
// 				"TIN No.":=vendor."T.I.N. No.";  */
//                 /*End
// 				else
// 				  */
//                 /*IF DTE."Source Type" = "Source Type"::Vendor THEN BEGIN
// 				   IF vendor.GET("Source No.") THEN BEGIN
// 					 BearerName:=vendor.Name;
// 					 "TIN No.":=vendor."T.I.N. No."
// 				  END;
// 				END;
// 				IF DTE."Source Type" = "Source Type"::Customer THEN BEGIN
// 				  IF Customer.GET("Source No.") THEN BEGIN
// 					 BearerName:=Customer.Name;
// 					 "TIN No.":=vendor."T.I.N. No."
// 				  END;
// 				END; */

//             end;

//         }
//     }

//     requestpage
//     {


//         SaveValues = false;
//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';

//                 }
//             }
//         }

//         actions
//         {
//         }
//     }
//     labels
//     {
//         A = 'Nature of Transaction*';
//         B = 'TIN*';
//         C = 'Name of the Purchaser';
//         D = 'Address of the Purchaser(District)';
//         E = 'Sr NO.of Invoice/ Challan*';
//         F = 'Date of Invoice/Challan(dd/mm/yyyy)*';
//         G = 'Trade Name*';
//         H = 'Commodity*';
//         I = 'Rate of Vat*';
//         J = 'Net Value of Goods/Value of Credit note (In case of Discount/Incentives )*';
//         K = 'Amount of Tax';
//         L = 'Additional Tax*';
//         M = 'Total*';
//         N = 'Credit Note No*';
//         O = 'Credit Note Date (dd/mm/yyyy)';
//         P = 'Nature of Transaction (In case of Disscount / Cancellation / sales Return)*';
//         Q = 'Quantity';
//     }



//     var
//         vendor: Record Vendor;
//         Customer: Record Customer;
//         BearerName: Text[100];
//         GLEntry: Record "G/L Account";
//         "TIN No.": Text[100];
//         DTE: Record "Detailed Tax Entry";
//         TaxAmt: Decimal;
//         TaxAmtC: Decimal;
//         TaxAmtVAT: Decimal;
//         AmtVAT: Decimal;
//         AmtVATTot: Decimal;
//         Sno: Decimal;


// }
