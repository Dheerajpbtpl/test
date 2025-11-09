// Report 50042 Annexure2AA
// {
//     RDLCLayout = './Layouts/Annexure2AA.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = where("Transaction Type" = filter(Purchase));
//             column(VendorCode; "Detailed Tax Entry"."Source No.")
//             {
//             }
//             column(PostingDate; "Detailed Tax Entry"."Posting Date")
//             {
//             }
//             column(FormCode; "Detailed Tax Entry"."Form Code")
//             {
//             }
//             column(TaxBaseAmount; "Detailed Tax Entry"."Tax Base Amount")
//             {
//             }
//             column(Tax; "Detailed Tax Entry"."Tax %")
//             {
//             }
//             column(TaxAmount; "Detailed Tax Entry"."Tax Amount")
//             {
//             }
//             column(CmpName; Company.Name)
//             {
//             }
//             column(RptName; 'Annexure 2A')
//             {
//             }
//             column(TINNo; Company."T.I.N. No.")
//             {
//             }
//             column(Address; Company.Address)
//             {
//             }
//             column(City; Company.City)
//             {
//             }
//             column(VendorName; VendorName)
//             {
//             }
//             column(SDate; SDate)
//             {
//             }
//             column(EDate; EDate)
//             {
//             }
//             column(SN; SN)
//             {
//             }
//             column(VendorTin; VendorTin)
//             {
//             }
//             column(Amount; Amount)
//             {
//             }
//             column(TotalAmount; TotalAmount)
//             {
//             }
//             trigger OnPreDataItem();
//             begin
//                 if SDate > 0D then
//                     SetRange("Posting Date", SDate, EDate);
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 SN += SN + 1;
//                 Vendor.Reset;
//                 Vendor.SetRange(Vendor."No.", "Detailed Tax Entry"."Source No.");
//                 if Vendor.FindFirst then
//                     VendorName := Vendor.Name;
//                 VendorTin := Vendor."T.I.N. No.";
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
//                 field("Start Date"; SDate)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("End Date"; EDate)
//                 {
//                     ApplicationArea = Basic;
//                 }

//             }
//         }

//         actions
//         {
//         }
//     }


//     trigger OnPreReport()
//     begin
//         Company.Get;
//         ;
//     end;

//     var
//         Company: Record "Company Information";
//         SN: Integer;
//         SDate: Date;
//         EDate: Date;
//         Vendor: Record Vendor;
//         VendorName: Text;
//         VendorTin: Code[30];
//         Amount: Decimal;
//         TotalAmount: Decimal;

// }