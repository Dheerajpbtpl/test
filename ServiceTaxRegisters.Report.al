// Report 50041 "Service Tax Registers"
// {
//     UsageCategory = ReportsAndAnalysis;
//     RDLCLayout = './Layouts/ServiceTaxRegisters.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Service Tax Entry"; "Service Tax Entry")
//         {
//             column(DocumentNo_ServiceTaxEntry; "Service Tax Entry"."Document No.")
//             {
//             }
//             column(Type; "Service Tax Entry".Type)
//             {
//             }
//             column(PostingDate_ServiceTaxEntry; "Service Tax Entry"."Posting Date")
//             {
//             }
//             column(PartyName; Name)
//             {
//             }
//             column(TaxableServices; "Service Tax Entry"."Service Tax Base Amount")
//             {
//             }
//             column(TweleveST; "Service Tax Entry"."Original S.T. Amount")
//             {
//             }
//             column(RegNo; "Service Tax Entry"."Service Tax Registration No.")
//             {
//             }
//             column(SrNo; SrNo)
//             {
//             }
//             column(CompanyName; Company.Name)
//             {
//             }
//             column(StartDate; StartDate)
//             {
//             }
//             column(EndDate; EndDate)
//             {
//             }
//             column(AllFilter; AllFilter)
//             {
//             }
//             column(TwoST; "Service Tax Entry"."Original S.T. eCess Amount")
//             {
//             }
//             column(OneST; "Service Tax Entry"."Original S.T. SHE Cess Amount")
//             {
//             }
//             column(Total; "Service Tax Base Amount" + "Original S.T. Amount" + "Original S.T. eCess Amount" + "Original S.T. SHE Cess Amount")
//             {
//             }
//             column(SBCessAmt; SBCessAmt)
//             {
//             }
//             column(KKCessAmt; KKCessAmt)
//             {
//             }
//             trigger OnPreDataItem();
//             begin
//                 SetRange("Posting Date", StartDate, EndDate);
//                 SetRange(Type, Type);
//                 SetRange("Service Tax Group Code", STGroup);
//                 SetRange("Service Tax Registration No.", "ST No.");
//                 AllFilter := GetFilters;
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 Name := '';
//                 Vendor.Reset;
//                 Vendor.SetRange(Vendor."No.", "Service Tax Entry"."Party Code");
//                 if Vendor.FindFirst then
//                     Name := Vendor.Name;
//                 Customr.Reset;
//                 Customr.SetRange(Customr."No.", "Service Tax Entry"."Party Code");
//                 if Customr.FindFirst then
//                     Name := Customr.Name;
//                 SrNo += 1;
//                 if Type = Type::Sale then begin
//                     SBCessAmt := 0;
//                     PostedStrOrderLineDet.Reset;
//                     PostedStrOrderLineDet.SetRange(PostedStrOrderLineDet.Type, PostedStrOrderLineDet.Type::Sale);
//                     PostedStrOrderLineDet.SetRange(PostedStrOrderLineDet."Invoice No.", "Service Tax Entry"."Document No.");
//                     PostedStrOrderLineDet.SetFilter(PostedStrOrderLineDet."Tax/Charge Code", '%1|%2', 'SBCESS', 'SB');
//                     if PostedStrOrderLineDet.FindFirst then begin
//                         PostedStrOrderLineDet.CalcSums(PostedStrOrderLineDet.Amount);
//                         SBCessAmt := PostedStrOrderLineDet.Amount;
//                     end;
//                     if "Service Tax Entry"."Document Type" = "Service Tax Entry"."document type"::Invoice then
//                         SBCessAmt := SBCessAmt * -1;
//                     KKCessAmt := 0;
//                     PostedStrOrderLineDet.Reset;
//                     PostedStrOrderLineDet.SetRange(PostedStrOrderLineDet.Type, PostedStrOrderLineDet.Type::Sale);
//                     PostedStrOrderLineDet.SetRange(PostedStrOrderLineDet."Invoice No.", "Service Tax Entry"."Document No.");
//                     PostedStrOrderLineDet.SetFilter(PostedStrOrderLineDet."Tax/Charge Code", '%1', 'KKCESS');
//                     if PostedStrOrderLineDet.FindFirst then begin
//                         PostedStrOrderLineDet.CalcSums(PostedStrOrderLineDet.Amount);
//                         KKCessAmt := PostedStrOrderLineDet.Amount;
//                     end;
//                     if "Service Tax Entry"."Document Type" = "Service Tax Entry"."document type"::Invoice then
//                         KKCessAmt := KKCessAmt * -1;
//                 end;
//                 if Type = Type::Purchase then begin
//                     SBCessAmt := 0;
//                     PostedStrOrderLineDet.Reset;
//                     PostedStrOrderLineDet.SetRange(PostedStrOrderLineDet.Type, PostedStrOrderLineDet.Type::Purchase);
//                     PostedStrOrderLineDet.SetRange(PostedStrOrderLineDet."Invoice No.", "Service Tax Entry"."Document No.");
//                     PostedStrOrderLineDet.SetFilter(PostedStrOrderLineDet."Tax/Charge Code", '%1|%2', 'SBCESS', 'SB');
//                     if PostedStrOrderLineDet.FindFirst then begin
//                         PostedStrOrderLineDet.CalcSums(PostedStrOrderLineDet.Amount);
//                         SBCessAmt := PostedStrOrderLineDet.Amount;
//                     end;
//                     if "Service Tax Entry"."Document Type" = "Service Tax Entry"."document type"::"Credit Memo" then
//                         SBCessAmt := SBCessAmt * -1;
//                     KKCessAmt := 0;
//                     PostedStrOrderLineDet.Reset;
//                     PostedStrOrderLineDet.SetRange(PostedStrOrderLineDet.Type, PostedStrOrderLineDet.Type::Purchase);
//                     PostedStrOrderLineDet.SetRange(PostedStrOrderLineDet."Invoice No.", "Service Tax Entry"."Document No.");
//                     PostedStrOrderLineDet.SetFilter(PostedStrOrderLineDet."Tax/Charge Code", '%1', 'KKCESS');
//                     if PostedStrOrderLineDet.FindFirst then begin
//                         PostedStrOrderLineDet.CalcSums(PostedStrOrderLineDet.Amount);
//                         KKCessAmt := PostedStrOrderLineDet.Amount;
//                     end;
//                     if "Service Tax Entry"."Document Type" = "Service Tax Entry"."document type"::"Credit Memo" then
//                         KKCessAmt := KKCessAmt * -1;
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
//                 field("Start Date"; StartDate)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("End Date"; EndDate)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(STGroup; STGroup)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Service Tax Group';
//                     TableRelation = "Service Tax Groups";
//                 }
//                 field("ST No."; "ST No.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'ST No.';
//                     TableRelation = "Service Tax Registration Nos.";
//                 }
//                 field(Type; "Service Tax Entry".Type)
//                 {
//                     ApplicationArea = Basic;
//                 }

//             }

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
//         StartDate: Date;
//         EndDate: Date;
//         StNo: Code[30];
//         SrNo: Integer;
//         Vendor: Record Vendor;
//         Name: Text;
//         Company: Record "Company Information";
//         Type: Option Sale,Purchase;
//         STGroup: Code[30];
//         "ST No.": Code[30];
//         AllFilter: Text;
//         Customr: Record Customer;
//         PostedStrOrderLineDet: Record "Posted Str Order Line Details";
//         SBCessAmt: Decimal;
//         KKCessAmt: Decimal;

// }