// Report 50100 "tax type chnge"
// {
//     RDLCLayout = './Layouts/taxtypechnge.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = where("Tax Type" = filter(VAT), "Document No." = filter('02-11-1013-028' | '02-11-1013-058' | '02-11-1113-002' | '02-11-1013-102' | '02-11-1113-009' | '02-11-1113-013' | '02-11-1113-022' | '02-11-1113-023' | '02-24-1113-007' | '02-11-1213-112'));
//             trigger OnAfterGetRecord();
//             begin
//                 "Detailed Tax Entry"."Tax Type" := "Detailed Tax Entry"."tax type"::CST;
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