// Report 50028 "temp udapte"
// {
//     Permissions = TableData "G/L Entry" = rimd;
//     RDLCLayout = './Layouts/tempudapte.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
//         {
//             DataItemTableView = where("Document No." = filter('02-20-1013-013' | '02-20-1013-019' | '02-20-1013-023' | '02-20-1013-027' | '02-20-1013-030' | '02-20-1013-032' | '02-20-1013-033' | '02-20-1013-050' | '02-20-1113-023' | '02-20-1113-036' | '02-20-1213-049' | '02-20-1213-070' | '02-20-1213-069'));
//             trigger OnAfterGetRecord();
//             begin
//                 "Detailed Tax Entry"."State Code" := 'ND';
//                 "Detailed Tax Entry".Modify;
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