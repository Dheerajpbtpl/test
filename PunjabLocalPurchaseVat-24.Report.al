// Report 50032 "Punjab Local Purchase Vat-24"
// {
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/PunjabLocalPurchaseVat-24.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = where("Source Type" = filter(Vendor), "Tax Type" = filter(VAT), "Location Code" = filter('*LDH*'));
//             PrintOnlyIfDetail = false;
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
//             column(INvoiceno; "Invoice NO")
//             {
//             }
//             column(TAXAMOUNTVALUES; TAXAMOUNTVALUES)
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
//                 /*
// 				IF "Detailed Tax Entry"."Source Type" = "Detailed Tax Entry"."Source Type"::Vendor THEN BEGIN
// 				vendor.GET("Detailed Tax Entry"."Source No.");
// 				BearerName:=vendor.Name;
// 				"TIN No.":=vendor."T.I.N. No.";
// 				//message("TIN No.");
// 				  */
//                 //akshya
//                 PurInvHed.Reset;
//                 PurInvHed.SetRange(PurInvHed."No.", "Detailed Tax Entry"."Document No.");
//                 PurInvHed.SetRange(PurInvHed.State, "Detailed Tax Entry"."State Code");
//                 if PurInvHed.FindFirst then
//                     "Invoice NO" := PurInvHed."Vendor Invoice No.";
//                 vendor1.Reset;
//                 vendor1.SetRange(vendor1."No.", "Detailed Tax Entry"."Source No.");
//                 vendor1.SetRange(vendor1."State Code", "Detailed Tax Entry"."State Code");
//                 if vendor1.FindFirst then begin
//                     if "Detailed Tax Entry"."Source Type" = "Detailed Tax Entry"."source type"::Vendor then
//                         BearerName := vendor1.Name;
//                     //IF vendor1."T.I.N. No." = '' THEN BEGIN
//                     "TIN No." := vendor1."T.I.N. No.";
//                     // END;
//                     // MESSAGE("TIN No.");
//                 end;
//                 /*End
// 				else
// 				if "Detailed Tax Entry"."Source Type" = "Detailed Tax Entry"."Source Type"::Customer then begin
// 				Customer.GET("Detailed Tax Entry"."Source No.");
// 				BearerName:=Customer.Name;
// 				"TIN No.":=Customer."T.I.N. No.";  */
//                 //END;
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
//                 if ("Detailed Tax Entry"."Tax %" <> 5) then
//                     TAXAMOUNTVALUES := "Detailed Tax Entry"."Tax Base Amount";

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
//         C = 'Name of the Seller';
//         D = 'Address of the Seller(District)';
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
//         P = 'Nature of Transaction (In case of Disscount / Cancellation / Purchase Return)*';
//         Q = 'Quantity (In Quintals)';
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
//         PurInvHed: Record "Purch. Inv. Header";
//         "Invoice NO": Text[100];
//         vendor1: Record Vendor;
//         TAXAMOUNTVALUES: Decimal;


// }
