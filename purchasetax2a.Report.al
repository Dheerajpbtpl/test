// Report 50026 "purchase tax 2a"
// {
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/purchasetax2a.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = where("Source Type" = filter(Vendor), "State Code" = filter('ND'));
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
//             column(AmtCstTot; AmtCstTot)
//             {
//             }
//             column(Amt; Amt)
//             {
//             }
//             column(TAxamtWCSt; TAxamtWCSt)
//             {
//             }
//             column(PucrAmt; PucrAmt)
//             {
//             }
//             column(Consignmenttransfer; Consignmenttransfer)
//             {
//             }
//             column(BranchTransfer; BranchTransfer)
//             {
//             }
//             trigger OnPreDataItem();
//             begin
//                 Sno := 0;
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
//                 TaxAmtCst := 0;
//                 AmtVATTot := 0;
//                 Amt := 0;
//                 TAxamtWCSt := 0;
//                 AmtCst := 0;
//                 TaxSurcharge := 0;
//                 if "Detailed Tax Entry"."Tax Type" = "Detailed Tax Entry"."tax type"::CST then begin
//                     if "Detailed Tax Entry"."Form Code" = 'C' then begin
//                         TaxAmtC := "Detailed Tax Entry"."Tax Base Amount";
//                         TaxAmtCst := "Detailed Tax Entry"."Tax Amount";
//                         Amt := TaxAmtC + TaxAmtCst;
//                     end else
//                         TaxAmt := "Detailed Tax Entry"."Tax Base Amount";
//                     if "Detailed Tax Entry"."Form Code" = '' then begin
//                         "Detailed Tax Entry".CalcFields("Detailed Tax Entry".SurchargePurchase);
//                         AmtCst := "Detailed Tax Entry"."Tax Amount";
//                         TaxSurcharge := ("Detailed Tax Entry".SurchargePurchase);
//                         TAxamtWCSt := TaxAmt + AmtCst + TaxSurcharge;
//                         //message(format(TaxSurcharge));
//                     end;
//                     //message(format(TAxamtWCSt));
//                 end else
//                     if "Detailed Tax Entry"."Tax Type" = "Detailed Tax Entry"."tax type"::VAT then begin
//                         TaxAmtVAT := "Detailed Tax Entry"."Tax Base Amount";
//                         AmtVAT := "Detailed Tax Entry"."Tax Amount";
//                         AmtVATTot := TaxAmtVAT + AmtVAT;
//                     end;
//                 "TIN No." := '';
//                 BearerName := '';
//                 if "Detailed Tax Entry"."Source Type" = "Detailed Tax Entry"."source type"::Vendor then begin
//                     vendor.Get("Detailed Tax Entry"."Source No.");
//                     BearerName := vendor.Name;
//                     "TIN No." := vendor."T.I.N. No.";
//                     PurInvHed.Reset;
//                     PurInvHed.SetRange(PurInvHed."No.", "Detailed Tax Entry"."Document No.");
//                     PurInvHed.SetRange(PurInvHed."Location Code", "Detailed Tax Entry"."Location Code");
//                     if PurInvHed.FindFirst then
//                         PucrAmt := PurInvHed.Amount;
//                     if "Detailed Tax Entry"."Form Code" = 'F' then begin
//                         if "Detailed Tax Entry"."Document Type" = "Detailed Tax Entry"."document type"::Invoice then begin
//                             Consignmenttransfer := "Detailed Tax Entry"."Tax Base Amount";
//                             //BranchTransfer:=0;
//                         end else
//                             BranchTransfer := "Detailed Tax Entry"."Tax Base Amount";
//                         // Consignmenttransfer:=0;
//                     end;
//                     /*End
//                     else
//                     if "Detailed Tax Entry"."Source Type" = "Detailed Tax Entry"."Source Type"::Customer then begin
//                     Customer.GET("Detailed Tax Entry"."Source No.");
//                     BearerName:=Customer.Name;
//                     "TIN No.":=Customer."T.I.N. No.";  */
//                 end;
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
//         C = 'Seller’s TIN (C03)';
//         D = 'Seller’s Name (C04)';
//         E = 'Import from Outside India (C05)';
//         F = 'High Seas Purchase (C06)';
//         G = 'Own Goods Received Back after job work against F-Form (C0';
//         H = 'Purchase from Unregistered Dealer/Composition Dealer/Non Creditable Goods/Against Retail Invoices/Tax free Goods/Labour & Services related to work contract/Tax invoices not eligible for ITC/Delhi dealers against Form-H/Capital Goods(Used for manufacturing of non-creditable goods) (C08)';
//         I = 'Other Dealer Received for job work against F-form (C0';
//         J = 'Inter State Purchase-Capital Goods (C10)';
//         K = 'Inter State Purchase -C Form (C11)';
//         L = 'Inter State Purchase -H Form (C12)';
//         M = 'Inter State Purchase-None (C13)';
//         N = 'Branch Transfer (C14)';
//         O = 'Consignment Transfer (C15)';
//         P = 'Local Purchase eligible-Capital Goods-Rate of Tax (C16)';
//         Q = 'Local Purchase eligible-Capital Goods-Purchase Amount (C17)';
//         R = 'Local Purchase eligible-Capital Goods-Input Tax Paid (C18)';
//         S = 'Local Purchase eligible-Capital Goods-Total Purchase including Tax (C19)';
//         T = 'Type of Purchase (C20)';
//         U = 'Local Purchase eligible-Others-Rate of Tax (C21)';
//         V = 'Local Purchase eligible-Others-Purchase Amount (C22)';
//         W = 'Local Purchase eligible-Others-Input Tax Paid (23)';
//         X = 'Local Purchase eligible-Others-Total Purchase including Tax (C24)';
//         Y = 'Rate of Tax on the Item under Delhi Value Added Tax Act,2004(C25)';
//     }

//     trigger OnInitReport()
//     begin
//         ;
//         ReportsForNavInit;

//     end;

//     trigger OnPostReport()
//     begin
//         ;
//         ReportForNav.Post;
//     end;

//     trigger OnPreReport()
//     begin
//         ;
//         ReportsForNavPre;
//     end;

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
//         AmtCstTot: Decimal;
//         TaxAmtCst: Decimal;
//         AmtCst: Decimal;
//         Amt: Decimal;
//         TAxamtWCSt: Decimal;
//         PurInvHed: Record "Purch. Inv. Header";
//         PucrAmt: Decimal;
//         TaxSurcharge: Decimal;
//         PurchInLine: Record "Purch. Inv. Line";
//         Consignmenttransfer: Decimal;
//         BranchTransfer: Decimal;

// }