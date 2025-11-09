// Report 50027 "sales tax 2b"
// {
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/salestax2b.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = where("Source Type" = filter(Customer), "State Code" = filter('ND'));
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
//             column(IncTaxAmt; IncTaxAmt)
//             {
//             }
//             column(ToAmt; ToAmt)
//             {
//             }
//             trigger OnPreDataItem();
//             begin
//                 Sno := 0;
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 Sno += 1;
//                 AmtVAT := 0;
//                 TaxAmt := 0;
//                 TaxAmtC := 0;
//                 TaxAmtVAT := 0;
//                 IncTaxAmt := 0;
//                 ToAmt := 0;
//                 AmtVATTot := 0;
//                 if "Detailed Tax Entry"."Tax Type" = "Detailed Tax Entry"."tax type"::CST then begin
//                     if "Detailed Tax Entry"."Form Code" = 'C' then begin
//                         TaxAmtC := "Detailed Tax Entry"."Tax Base Amount";
//                         IncTaxAmt := "Detailed Tax Entry"."Tax Amount";
//                         ToAmt := TaxAmtC + IncTaxAmt;
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
//         A = 'C01';
//         B = 'Year & (Month or Quarter) (YYYYMM or YYYYQQ)';
//         C = 'Buyer’s TIN (C03)';
//         D = 'Buyer’s Name (C04)';
//         E = '"Inter-State Branch Transfer(C05)"';
//         F = '"Inter-State Consignment Transfer(C06)"';
//         G = 'Export Out of India (C07)';
//         H = 'High Sea Sales (C08)';
//         I = 'ISS-Goods Type/ISS-Transaction Type (C09)';
//         J = 'ISS-Form Type (C10)';
//         K = 'ISS-Rate of Tax (C11)';
//         L = '"ISS-Sales Price (Excluding CST)(C12)"';
//         M = 'ISS-Central Sales Tax (C13)';
//         N = 'ISS-Total (C14)';
//         O = '"Local Sale-Type of Sale(C15)"';
//         P = 'Local Sale-Rate of Tax (C16)';
//         Q = '"Local Sale-Sales Price (Excluding VAT)(C17)"';
//         R = '"Local Sale-Output Tax(C18)"';
//         S = 'Local Sale-Total (including VAT) (C19)';
//         T = '"Rate of Tax on the Item under Delhi Value Added Tax Act,2004(C20)"';
//         U = '"Sale of Diesel & Petrol as have suffered Tax in hands of Various Oil Marketing Companies in Delhi(C21)"';
//         V = 'Charges towards labour,services and other like charges in civil works contracts(C22)';
//         W = '"Charges towards cost of land,if any, in services civil works contracts(C23)"';
//         X = '"Sales Against H-form to Delhi dealer(C24)"';
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
//         IncTaxAmt: Decimal;
//         ToAmt: Decimal;

// }