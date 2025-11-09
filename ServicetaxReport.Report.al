// Report 50022 "Service tax Report"
// {
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/ServicetaxReport.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Service Tax Entry"; "Service Tax Entry")
//         {
//             column(PostingDate; "Service Tax Entry"."Posting Date")
//             {
//             }
//             column(Invoice_NO; "Invoice NO")
//             {
//             }
//             column(custname; custname)
//             {
//             }
//             column(Type; "Service Tax Entry".Type)
//             {
//             }
//             column(DocumentNumber; "Service Tax Entry"."Document No.")
//             {
//             }
//             column(BaseAmount; "Service Tax Entry"."Service Tax Base Amount")
//             {
//             }
//             column(ServiceTax; "Service Tax Entry"."Service Tax %")
//             {
//             }
//             column(Servicetaxamt; "Service Tax Entry"."Service Tax Amount")
//             {
//             }
//             column(Ecess; "Service Tax Entry"."Service Tax eCess %")
//             {
//             }
//             column(EcessAmount; "Service Tax Entry"."eCess Amount")
//             {
//             }
//             column(Shecess; "Service Tax Entry"."Service Tax SHE Cess %")
//             {
//             }
//             column(ShevessAmount; "Service Tax Entry"."SHE Cess Amount")
//             {
//             }
//             column(Locationcode; "Service Tax Entry"."Location Code")
//             {
//             }
//             column(DocumentType_ServiceTaxEntry; "Service Tax Entry"."Document Type")
//             {
//             }
//             trigger OnAfterGetRecord();
//             begin
//                 cust.Reset;
//                 cust.SetRange(cust."No.", "Service Tax Entry"."Party Code");
//                 if cust.FindFirst then
//                     custname := cust.Name;
//                 Vendr.Reset;
//                 Vendr.SetRange(Vendr."No.", "Service Tax Entry"."Party Code");
//                 if Vendr.FindFirst then
//                     custname := Vendr.Name;
//                 SalesInvHedr.Reset;
//                 SalesInvHedr.SetRange(SalesInvHedr."Sell-to Customer No.", "Service Tax Entry"."Party Code");
//                 SalesInvHedr.SetRange(SalesInvHedr."No.", "Service Tax Entry"."Document No.");
//                 if SalesInvHedr.FindFirst then
//                     if "Service Tax Entry"."Document Type" = "Service Tax Entry"."document type"::Invoice then
//                         "Invoice NO" := SalesInvHedr."No."
//                     else
//                         if "Service Tax Entry"."Document Type" = "Service Tax Entry"."document type"::"Credit Memo" then
//                             "Invoice NO" := "Service Tax Entry"."Document No.";
//                 "Invoice NO" := "Service Tax Entry"."Document No.";
//                 PurInvHed.Reset;
//                 PurInvHed.SetRange(PurInvHed."Buy-from Vendor No.", "Service Tax Entry"."Party Code");
//                 if PurInvHed.FindFirst then
//                     "Invoice NO" := PurInvHed."Vendor Invoice No.";
//                 //message("Invoice NO");
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

//     var
//         cust: Record Customer;
//         custname: Text[100];
//         SalesInvHedr: Record "Sales Invoice Header";
//         "Invoice NO": Code[50];
//         Vendr: Record Vendor;
//         PurInvHed: Record "Purch. Inv. Header";
//         SerVTaXEnTRY: Record "Service Tax Entry";

// }