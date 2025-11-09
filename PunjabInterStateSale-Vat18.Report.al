// Report 50030 "PunjabInter State Sale- Vat 18"
// {
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/PunjabInterStateSale-Vat18.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = where("Source Type" = filter(Customer), "Tax Type" = filter(CST), "Location Code" = filter('*LDH*'));
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
//                 /*DTE.RESET;
// 				//DTE.SETRANGE(DTE."Entry No.",1,100000);
// 				DTE.SETRANGE("Entry No.",1,100000);
// 				IF DTE.FINDFIRST THEN BEGIN
// 				  REPEAT
// 					  IF DTE."Source Type" = DTE."Source Type"::Vendor THEN BEGIN
// 						 IF vendor.GET(DTE."Source No.") THEN BEGIN
// 						   BearerName:=vendor.Name;
// 						   "TIN No.":=vendor."T.I.N. No."
// 						END;
// 					  END;
// 					  IF DTE."Source Type" = DTE."Source Type"::Customer THEN BEGIN
// 						IF Customer.GET(DTE."Source No.") THEN BEGIN
// 						   BearerName:=Customer.Name;
// 						   "TIN No.":=vendor."T.I.N. No."
// 						END;
// 					  END;
// 				  UNTIL (DTE.NEXT=0) OR (BearerName<>'');
// 				END; */
//                 /*
// 				IF "Detailed Tax Entry"."Tax Type" = "Detailed Tax Entry"."Tax Type"::CST AND "Detailed Tax Entry"."Form Code" = "Detailed Tax Entry"."Form Code"::C THEN BEGIN
// 					TaxAmt:="Detailed Tax Entry"."Tax Amount";
// 				  END ELSE
// 					TaxAmt:="Detailed Tax Entry"."Tax Amount";
// 				END; */

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
//                 // MESSAGE("TIN No.");
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

//             trigger OnPostDataItem();
//             begin
//                 /*IF vend.GET("Source No.") THEN BEGIN
// 				IF vend.GET("Source No.") THEN BEGIN
// 				GLEntry.SETRANGE(GLEntry."Document No.","Bank Account Ledger Entry"."Document No.");
// 				LedgAmount:=ABS("Bank Account Ledger Entry".Amount);
// 				ReportCheck.InitTextVariable;
// 				ReportCheck.FormatNoText(Numbertext,LedgAmount,"Bank Account Ledger Entry"."Currency Code");
// 				GLEntry.RESET;
// 				GLEntry.SETRANGE(GLEntry."Document No.","Bank Account Ledger Entry"."Document No.");
// 				GLEntry.SETRANGE(GLEntry."Posting Date","Bank Account Ledger Entry"."Posting Date");
// 				//GLEntry.SETFILTER(GLEntry."Source Type",'<>%1',GLEntry."Source Type"::"Bank Account");
// 				IF GLEntry.FINDFIRST THEN BEGIN
// 				  REPEAT
// 					  IF GLEntry."Source Type" = GLEntry."Source Type"::Vendor THEN BEGIN
// 						IF vendor.GET(GLEntry."Source No.") THEN BEGIN
// 						   BearerName:=vendor.Name;
// 						END;
// 					  END;
// 					  IF GLEntry."Source Type" = GLEntry."Source Type"::Customer THEN BEGIN
// 						IF Customer.GET(GLEntry."Source No.") THEN BEGIN
// 						   BearerName:=Customer.Name;
// 						END;
// 					  END;
// 				  UNTIL (GLEntry.NEXT=0) OR (BearerName<>'');
// 				END;
// 				*/

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
//         A = 'Nature of  Transaction*';
//         B = 'TIN/CST No*';
//         C = 'Name of  The Purchaser';
//         D = 'Address of  The Purchaser (State)';
//         E = 'Sr.No of Invoice/Challan';
//         F = 'Date of Invoice/ Challan(dd/mm/yyyy)';
//         G = 'Description of Goods/ commodity*';
//         H = 'Quantity of Goods (in Quintals)';
//         I = 'Value of Goods (Rs.)*';
//         J = 'Value of Freight';
//         K = 'Name of Transporter';
//         L = 'GR/RR etc.Details';
//         M = 'Number';
//         N = 'Date (dd/mm/yyyy)';
//         O = 'Nature of Transaction(In case of Discount / Cancellation / Sales Return)*';
//         P = 'Entry Tax Paid if Any(Only in case of Cancellation of Sales/ Sales Return)';
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
