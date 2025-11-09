// Report 50038 Annexure2A
// {
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/Annexure2A.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = where("Transaction Type" = const(Purchase));
//             RequestFilterFields = "State Code";
//             column(PostingDate; "Detailed Tax Entry"."Posting Date")
//             {
//             }
//             column(VendorName; vendor.Name)
//             {
//             }
//             column(VendorTin; vendor."T.I.N. No.")
//             {
//             }
//             column(PurchageAmount; "Purchage amount")
//             {
//             }
//             column(RateOfTax; "Rate of Tax")
//             {
//             }
//             column(InputTaxPaid; "Input Tax Paid")
//             {
//             }
//             column(TotalPurchage; "Total Purchage")
//             {
//             }
//             column(Cform; "c form")
//             {
//             }
//             column(Hform; "h form")
//             {
//             }
//             column(CompanyName; Company.Name)
//             {
//             }
//             column(CompanyAddress; Company.Address)
//             {
//             }
//             column(CompanyTIN; Company."T.I.N. No.")
//             {
//             }
//             column(VendorSourceNo; "Detailed Tax Entry"."Source No.")
//             {
//             }
//             column(BranchTransfer; BranchTransfer)
//             {
//             }
//             column(Consignmenttransfer; Consignmenttransfer)
//             {
//             }
//             column(StartDate; StartDate)
//             {
//             }
//             column(Enddate; EndDate)
//             {
//             }
//             column(Caddress2; Company."Address 2")
//             {
//             }
//             column(city; Company.City)
//             {
//             }
//             column(S_no; "SI.NO")
//             {
//             }
//             trigger OnPreDataItem();
//             begin
//                 "Detailed Tax Entry".SetRange("Detailed Tax Entry"."Posting Date", StartDate, EndDate);
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 // "SI.NO"+= 1;
//                 "c form" := 0;
//                 "h form" := 0;
//                 Consignmenttransfer := 0;
//                 BranchTransfer := 0;
//                 if vendor.Get("Detailed Tax Entry"."Source No.") then begin
//                     if PreviousVendor <> vendor."No." then begin
//                         PreviousVendor := vendor."No.";
//                         "Purchage amount" := 0;
//                         "Rate of Tax" := 0;
//                         "Input Tax Paid" := 0;
//                         "Total Purchage" := 0;
//                         // "c form":=0;
//                         //"h form":=0;
//                         // Consignmenttransfer:=0;
//                         //BranchTransfer:=0;
//                         "SI.NO" += 1;
//                     end;
//                 end;
//                 if location.Get("Detailed Tax Entry"."Location Code") then;
//                 if "Detailed Tax Entry"."Tax Type" = "Detailed Tax Entry"."tax type"::VAT then begin
//                     "Purchage amount" := "Detailed Tax Entry"."Tax Base Amount";
//                     "Rate of Tax" := "Detailed Tax Entry"."Tax %";
//                     "Input Tax Paid" := "Detailed Tax Entry"."Tax Amount";
//                     "Total Purchage" := "Purchage amount" + "Input Tax Paid";
//                     // "c form":=0;
//                     //"h form":=0;
//                     //Consignmenttransfer:=0;
//                     //BranchTransfer:=0;
//                 end;
//                 if "Detailed Tax Entry"."Tax Type" = "Detailed Tax Entry"."tax type"::CST then begin
//                     if "Detailed Tax Entry"."Form Code" = 'C' then
//                         "c form" := "Detailed Tax Entry"."Tax Base Amount";
//                     //"h form":=0;
//                     //Consignmenttransfer:=0;
//                     //BranchTransfer:=0;
//                     if "Detailed Tax Entry"."Form Code" = 'H' then
//                         "h form" := "Detailed Tax Entry"."Tax Base Amount";
//                     //Consignmenttransfer:=0;
//                     //BranchTransfer:=0;
//                     //"c form":=0;
//                     if "Detailed Tax Entry"."Form Code" = 'F' then begin
//                         if "Detailed Tax Entry"."Document Type" = "Detailed Tax Entry"."document type"::Invoice then begin
//                             Consignmenttransfer := "Detailed Tax Entry"."Tax Base Amount";
//                             BranchTransfer := 0;
//                             //"c form":=0;
//                             "h form" := 0;
//                         end else
//                             BranchTransfer := "Detailed Tax Entry"."Tax Base Amount";
//                         Consignmenttransfer := 0;
//                         // "c form":=0;
//                         // "h form":=0;
//                     end;
//                     "Purchage amount" := 0;
//                     "Input Tax Paid" := 0;
//                     "Rate of Tax" := 0;
//                     "Total Purchage" := 0;
//                 end;
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
//                 field(Month; month)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Year; year)
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
//         if Company.Get then;
//         PreviousVendor := '';
//         "SI.NO" := 0;
//         intDay := 1;
//         Evaluate(intMonth, Format(month));
//         intYear := year;
//         Date1 := Dmy2date(intDay, intMonth, intYear);
//         StartDate := CalcDate('CM + 1D - 1M', Date1);
//         EndDate := CalcDate('CM', Date1);
//         ;
//     end;

//     var
//         Company: Record "Company Information";
//         "SI.NO": Integer;
//         vendor: Record Vendor;
//         location: Record Location;
//         "Purchage amount": Decimal;
//         "Rate of Tax": Decimal;
//         "Input Tax Paid": Decimal;
//         "Total Purchage": Decimal;
//         "c form": Decimal;
//         "h form": Decimal;
//         BranchTransfer: Decimal;
//         Consignmenttransfer: Decimal;
//         YearMonth: DateFormula;
//         month: Option "01","02","03","04","05","06","07","08","09","10","11","12";
//         year: Integer;
//         StartDate: Date;
//         EndDate: Date;
//         Date1: Date;
//         intDay: Integer;
//         intMonth: Integer;
//         intYear: Integer;
//         PreviousVendor: Code[10];

// }