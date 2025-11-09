// /// <summary>
// /// Report GSTR Txt Generation (ID 50198).
// /// </summary>
// /// Taneesh
// Report 50198 "GSTR Txt Generation"
// {
//     RDLCLayout = './Layouts/GSTRTxtGeneration.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem(Integer; Integer)
//         {
//             trigger OnPreDataItem();
//             begin
//                 SetRange(Number, 1, 1);
//                 //VarDtStr:=FORMAT(TODAY,11,'<Year4>-<Month Text,3>-<Day,2>');
//                 //MESSAGE(VarDtStr);
//                 //FORMAT(dateValue,10,'<Year4>/<Month,2>/<Day,2>');
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 FileGenType := 'Export:' + Format(ExportType);
//                 if not IsDocIssue then begin
//                     repeat
//                         //MESSAGE(FORMAT(StartDate));
//                         if ReturnType = Returntype::GSTR01 then begin
//                             if (InvoiceType = Invoicetype::All) or (InvoiceType = Invoicetype::Invoice) then
//                                 CUGSTRMgmt.GSTReturnData('GSTR01INVOICE', FileFolderPath, StartDate, StartDate, InputGSTINNo, 'Create', FileGenType);
//                             if (InvoiceType = Invoicetype::All) or (InvoiceType = Invoicetype::Return) then
//                                 CUGSTRMgmt.GSTReturnData('GSTR01RETURN', FileFolderPath, StartDate, StartDate, InputGSTINNo, 'Create', FileGenType);
//                             if (InvoiceType = Invoicetype::All) or (InvoiceType = Invoicetype::Transfer) then
//                                 CUGSTRMgmt.GSTReturnData('GSTR01TRANSFER', FileFolderPath, StartDate, StartDate, InputGSTINNo, 'Create', FileGenType);
//                         end;
//                         if ReturnType = Returntype::GSTR02 then begin
//                             if (InvoiceType = Invoicetype::All) or (InvoiceType = Invoicetype::Invoice) then
//                                 CUGSTRMgmt.GSTReturnData('GSTR02INVOICE', FileFolderPath, StartDate, StartDate, InputGSTINNo, 'Create', FileGenType);
//                             if (InvoiceType = Invoicetype::All) or (InvoiceType = Invoicetype::Return) then
//                                 CUGSTRMgmt.GSTReturnData('GSTR02RETURN', FileFolderPath, StartDate, StartDate, InputGSTINNo, 'Create', FileGenType);
//                             if (InvoiceType = Invoicetype::All) or (InvoiceType = Invoicetype::Transfer) then
//                                 CUGSTRMgmt.GSTReturnData('GSTR02TRANSFER', FileFolderPath, StartDate, StartDate, InputGSTINNo, 'Create', FileGenType);
//                         end;
//                         StartDate := StartDate + 1;
//                     until EndDate < StartDate;
//                 end else begin
//                     CUGSTRMgmt.GSTReturnData('DOCISSUE', FileFolderPath, StartDate, EndDate, InputGSTINNo, 'Create', FileGenType);
//                 end;
//             end;

//             trigger OnPostDataItem();
//             begin
//                 Message('Completed');
//             end;

//         }
//     }

//     requestpage
//     {

//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 field(DOCISSUE; IsDocIssue)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Return Type."; ReturnType)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Invoice Type"; InvoiceType)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Start Date"; StartDate)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("End Date"; EndDate)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("GSTN No"; InputGSTINNo)
//                 {
//                     ApplicationArea = Basic;
//                     TableRelation = "GST Registration Nos.".Code;
//                 }
//                 field("Folder Path"; FileFolderPath)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Export Type"; ExportType)
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
//         StartDate: Date;
//         EndDate: Date;
//         CUGSTRMgmt: Codeunit "ASP GST Management";
//         InputGSTINNo: Text;
//         InvType: Option GSTR01INVOICE,GSTR01RETURN,GSTR01TRANSFER;
//         FileFolderPath: Text;
//         ReturnType: Option GSTR01,GSTR02;
//         VarDt: Date;
//         VarDtStr: Text;
//         InvoiceType: Option All,Invoice,Return,Transfer;
//         IsDocIssue: Boolean;
//         ExportType: Option "LOCAL",FTP;
//         FileGenType: Text;


// }
