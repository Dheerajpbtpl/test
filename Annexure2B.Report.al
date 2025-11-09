// /// <summary>
// /// Report Annexure 2B (ID 50039).
// /// </summary>
// Report 50039 "Annexure 2B"
// {
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/Annexure2B.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = where("Transaction Type" = const(Sale));
//             RequestFilterFields = "State Code";
//             column(CustomerSourceNo; "Detailed Tax Entry"."Source No.")
//             {
//             }
//             column(FormType; formtype)
//             {
//             }
//             column(RateOfTaxCST; "Rate of tax CST")
//             {
//             }
//             column(SalesPriceCST; salespriceCST)
//             {
//             }
//             column(CentralTAX; CentralTax)
//             {
//             }
//             column(Total; total)
//             {
//             }
//             column(SalesPriceVAT; SalesTaxVAT)
//             {
//             }
//             column(RateOfTaxVAT; "Rate of Tax VAT")
//             {
//             }
//             column(OutputTax; OutputTax)
//             {
//             }
//             column(BuyersName; customer.Name)
//             {
//             }
//             column(BuyersTIN; customer."T.I.N. No.")
//             {
//             }
//             column(DealerName; company.Name)
//             {
//             }
//             column(Address1; company.Address)
//             {
//             }
//             column(TIN; 'company."T.I.N. No."')
//             {
//             }
//             column(Address2; company."Address 2")
//             {
//             }
//             column(Address3; company.City)
//             {
//             }
//             column(StartDate; Startdate)
//             {
//             }
//             column(EndDate; EndDate)
//             {
//             }
//             column(si_no; s_no)
//             {
//             }
//             column(SalesType; SalesType)
//             {
//             }
//             column(GoodsType; GoodsType)
//             {
//             }
//             column(PostingDate; "Detailed Tax Entry"."Posting Date")
//             {
//             }
//             column(TaxBaseAmount; "Detailed Tax Entry"."Tax Base Amount")
//             {
//             }
//             column(DocumentNo_DetailedTaxEntry; "Detailed Tax Entry"."Document No.")
//             {
//             }
//             trigger OnPreDataItem();
//             begin
//                 "Detailed Tax Entry".SetRange("Detailed Tax Entry"."Posting Date", Startdate, EndDate);
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 // s_no+=1;
//                 SalesTaxVAT := 0;
//                 OutputTax := 0;
//                 // IF ( VarDocmtNo <> "Detailed Tax Entry"."Document No.") THEN BEGIN
//                 if customer.Get("Detailed Tax Entry"."Source No.") then begin
//                     if PrevCustomer <> customer."No." then begin
//                         PrevCustomer := customer."No.";
//                         salespriceCST := 0;
//                         CentralTax := 0;
//                         total := 0;
//                         // SalesTaxVAT := 0;
//                         // OutputTax := 0;
//                         "Rate of Tax VAT" := 0;
//                         // SalesTaxVAT := 0;
//                         // OutputTax :=0;
//                         s_no += 1;
//                     end;
//                 end;
//                 //END;
//                 // IF ( VarDocmtNo <> "Detailed Tax Entry"."Document No.") THEN BEGIN
//                 if "Detailed Tax Entry"."Tax Type" = "Detailed Tax Entry"."tax type"::CST then begin
//                     formtype := "Detailed Tax Entry"."Form Code";
//                     "Rate of tax CST" := "Detailed Tax Entry"."Tax %";
//                     salespriceCST := "Detailed Tax Entry"."Tax Base Amount";
//                     CentralTax := "Detailed Tax Entry"."Tax Amount";
//                     // total := total + salespriceCST + CentralTax ;
//                     GoodsType := 'OT';
//                     "Rate of Tax VAT" := 0;
//                     // SalesTaxVAT := 0;
//                     // OutputTax :=0;
//                     SalesType := '';
//                 end;
//                 // END;
//                 // IF ( VarDocmtNo<> "Detailed Tax Entry"."Document No.") THEN BEGIN
//                 if ("Detailed Tax Entry"."Tax Type" = "Detailed Tax Entry"."tax type"::VAT) then begin
//                     "Rate of Tax VAT" := "Detailed Tax Entry"."Tax %";
//                     SalesTaxVAT := "Detailed Tax Entry"."Tax Base Amount";
//                     OutputTax := "Detailed Tax Entry"."Tax Amount";
//                     SalesType := 'GD';
//                     "Rate of tax CST" := 0;
//                     salespriceCST := 0;
//                     CentralTax := 0;
//                     GoodsType := '';
//                     formtype := '';
//                 end;
//                 // END;
//                 VarDocmtNo := "Detailed Tax Entry"."Document No.";
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
//                 field(ForNavOpenDesigner; ReportForNavOpenDesigner)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Design';
//                     Visible = ReportForNavAllowDesign;
//                 }
//             }
//         }

//         actions
//         {
//         }
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
//         if company.Get then;
//         PrevCustomer := '';
//         s_no := 0;
//         intday := 1;
//         Evaluate(intmonth, Format(month));
//         intyear := year;
//         Date1 := Dmy2date(intday, intmonth, intyear);
//         Startdate := CalcDate('CM + 1D - 1M', Date1);
//         EndDate := CalcDate('CM', Date1);
//         ;
//         ReportsForNavPre;
//     end;

//     var
//         company: Record "Company Information";
//         customer: Record Customer;
//         formtype: Text;
//         "Rate of tax CST": Decimal;
//         salespriceCST: Decimal;
//         CentralTax: Decimal;
//         total: Decimal;
//         SalesTaxVAT: Decimal;
//         "Rate of Tax VAT": Decimal;
//         OutputTax: Decimal;
//         month: Option "01","02","03","04","05","06","07","08","09","10","11","12";
//         year: Integer;
//         intday: Integer;
//         intmonth: Integer;
//         intyear: Integer;
//         Date1: Date;
//         Startdate: Date;
//         EndDate: Date;
//         s_no: Integer;
//         GoodsType: Text;
//         SalesType: Text;
//         PrevCustomer: Code[20];
//         VarDocmtNo: Code[20];

//     // --> Reports ForNAV Autogenerated code - do not delete or modify
//     var
//         [WithEvents]
//         ReportForNav: DotNet ForNavReport50039_v7_0_0_2350;
//         ReportForNavOpenDesigner: Boolean;
//         [InDataSet]
//         ReportForNavAllowDesign: Boolean;

//     local procedure ReportsForNavInit();
//     var
//         ApplicationSystemConstants: Codeunit "Application System Constants";
//         addInFileName: Text;
//         tempAddInFileName: Text;
//         path: DotNet Path;
//         ReportForNavObject: Variant;
//     begin
//         addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_7_0_0_2350\ForNav.Reports.7.0.0.2350.dll';
//         if not File.Exists(addInFileName) then begin
//             tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.7.0.0.2350.dll';
//             if not File.Exists(tempAddInFileName) then
//                 Error('Please install the ForNAV DLL version 7.0.0.2350 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
//         end;
//         ReportForNavObject := ReportForNav.GetLatest(CurrReport.OBJECTID, CurrReport.Language, SerialNumber, UserId, CompanyName);
//         ReportForNav := ReportForNavObject;
//         ReportForNav.Init();
//     end;

//     local procedure ReportsForNavPre();
//     begin
//         ReportForNav.OpenDesigner := ReportForNavOpenDesigner;
//         if not ReportForNav.Pre() then CurrReport.Quit();
//     end;

//     // Reports ForNAV Autogenerated code - do not delete or modify -->
// }
