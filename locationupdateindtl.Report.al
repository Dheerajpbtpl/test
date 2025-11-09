// /// <summary>
// /// Report location update in dtl (ID 50088).
// /// </summary>
// Report 50088 "location update in dtl"
// {
//     Permissions = TableData "Detailed Tax Entry" = rimd;
//     RDLCLayout = './Layouts/locationupdateindtl.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = where("Document No." = filter('02-20-1013-010'));
//             trigger OnAfterGetRecord();
//             begin
//                 "Detailed Tax Entry"."Location Code" := 'DEL-VAT';
//                 Modify;
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




// }
