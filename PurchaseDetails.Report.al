// Report 50103 "Purchase Details"
// {
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/PurchaseDetails.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
//         {
//             CalcFields = "SbCess Amount", "Service Tax Base Amount", "Tax Base Amount", "Tax Amount", "Service Tax Amount";
//             column(DocumentNo_TaxEntry; "Purch. Inv. Header"."No.")
//             {
//             }
//             column(PostingDate_TaxEntry; "Purch. Inv. Header"."Posting Date")
//             {
//             }
//             column(CustName; "Purch. Inv. Header"."Buy-from Vendor Name")
//             {
//             }
//             column(Base_TaxEntry; "Purch. Inv. Header"."Tax Base Amount")
//             {
//             }
//             column(Amount_TaxEntry; "Purch. Inv. Header"."Tax Amount")
//             {
//             }
//             column(SerAmt; "Purch. Inv. Header"."Service Tax Amount" + "SbCess Amount")
//             {
//             }
//             column(TotalAmt; AMountToVendor)
//             {
//             }
//             column(Opening; Opening)
//             {
//             }
//             column(TaxOpening; TaxOpening)
//             {
//             }
//             column(SerOpening; SerOpening)
//             {
//             }
//             column(OpeningTotal; OpeningTotal)
//             {
//             }
//             column(ServiceTaxBaseAmount; "Purch. Inv. Header"."Service Tax Base Amount")
//             {
//             }
//             column(TaxBaseAmt; TaxBaseAmt)
//             {
//             }
//             column(SerTaxBase; SerTaxBase)
//             {
//             }
//             trigger OnPreDataItem();
//             begin
//                 SetRange("Posting Date", StartDate, EndDate);
//                 Opening := 0;
//                 TaxOpening := 0;
//                 SerOpening := 0;
//                 OpeningTotal := 0;
//                 SerTaxBase := 0;
//                 TaxEntry.Reset;
//                 TaxEntry.SetFilter(TaxEntry."Posting Date", '<%1', StartDate);
//                 TaxEntry.SetRange(TaxEntry.Type, TaxEntry.Type::Purchase);
//                 if TaxEntry.FindFirst then begin
//                     TaxEntry.CalcSums(TaxEntry.Base);
//                     Opening := TaxEntry.Base;
//                     TaxEntry.CalcSums(TaxEntry.Amount);
//                     TaxOpening := TaxEntry.Amount;
//                 end;
//                 SerTaxEntry.Reset;
//                 SerTaxEntry.SetFilter("Posting Date", '<%1', StartDate);
//                 SerTaxEntry.SetRange(SerTaxEntry.Type, SerTaxEntry.Type::Purchase);
//                 if SerTaxEntry.FindFirst then begin
//                     SerTaxEntry.CalcSums(SerTaxEntry."Service Tax Amount");
//                     SerOpening := SerTaxEntry."Service Tax Amount";
//                     SerTaxEntry.CalcSums(SerTaxEntry."Base Amount");
//                     SerTaxBase := SerTaxEntry."Base Amount"
//                 end;
//                 OpeningTotal := ROUND(SerOpening, 2, '=') + ROUND(Opening, 2, '=') + ROUND(TaxOpening, 2, '=');

//                 AMountToVendor := 0;
//                 VendorLedEntry.Reset();
//                 VendorLedEntry.SetRange("Document No.", "Purch. Inv. Header"."No.");
//                 VendorLedEntry.CalcSums(Amount);
//                 AMountToVendor := VendorLedEntry.Amount;

//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 TaxBaseAmt := 0;
//                 CalcFields("Tax Amount", "Tax Base Amount");
//                 if "Tax Amount" = 0 then
//                     TaxBaseAmt := 0
//                 else
//                     TaxBaseAmt := "Tax Base Amount";
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
//                 field("Start Date"; StartDate)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("End Date"; EndDate)
//                 {
//                     ApplicationArea = Basic;
//                 }

//             }
//         }

//         actions
//         {
//         }
//     }



//     var
//         AMountToVendor: Decimal;
//         VendorLedEntry: Record "Vendor Ledger Entry";
//         Vendor: Record Vendor;
//         CustName: Text;
//         SerTaxEntry: Record "Service Tax Entry Details";
//         SerAmt: Decimal;
//         TotalAmt: Decimal;
//         StartDate: Date;
//         EndDate: Date;
//         TaxEntry: Record "Tax Entry";
//         Opening: Decimal;
//         TaxOpening: Decimal;
//         SerOpening: Decimal;
//         OpeningTotal: Integer;
//         TaxBaseAmt: Decimal;
//         SerTaxBase: Decimal;

// }