// /// <summary>
// /// Report Export Document In XML (ID 50020).
// /// </summary>
// Report 50020 "Export Document In XML"
// {
//     ProcessingOnly = true;
//     UsageCategory = ReportsandAnalysis;

//     dataset
//     {
//         dataitem("Integer"; "Integer")
//         {


//             trigger OnAfterGetRecord()
//             begin

//                 SendDataToTally;

//                 WinDialog.Close;

//                 ClearAll;

//                 Message('Done');
//             end;

//             trigger OnPreDataItem()
//             begin
//                 SetRange(Number, 1, 1);
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
//                 field("Tally Link Url"; TallyLinkUrl)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Tally Company Name"; TallyCompanyName)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Document Type"; DoctType)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Location; LocCode)
//                 {
//                     ApplicationArea = Basic;
//                     TableRelation = Location;
//                 }
//                 field("Start Date"; StartDate)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("End Date"; EndDate)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Export Type"; ExportType)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Document No"; VarDoctNo)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Master Naming"; MasterNaming)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Round Off Account."; RoundAcctNo)
//                 {
//                     ApplicationArea = Basic;
//                     TableRelation = "G/L Account";
//                 }
//                 field("Export Master"; ExportMaster)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Export Transaction"; ExportTransaction)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }

//         actions
//         {
//         }

//         trigger OnOpenPage()
//         begin
//             MasterNaming := Masternaming::"Code-Name";

//             GLSetup.Get;
//             RoundAcctNo := GLSetup."GST Inv. Rounding Account";


//             TallyLinkUrl := 'http://localhost:9000';

//             ExportMaster := true;
//             ExportTransaction := true;
//         end;
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     var
//         InDate: Date;
//     begin
//         /*
//         IF LocRec.FINDFIRST THEN REPEAT
//            IF LocRec."Tally Godown Name"='' THEN
//             LocRec."Tally Godown Name":=LocRec.City;
//            LocRec.MODIFY;
//         UNTIL LocRec.NEXT=0;
//         */

//         CurrencyFactor := 1;

//     end;

//     var
//         ExpObjectType: Option " ",Master,Transaction;
//         DoctType: Option ,"Sales Invoice","Sales CrMemo","Purchase Invoice","Purchase CrMemo","Transfer Shipment","Transfer Receipt","Service Invoice","Service CrMemo",Payment,Receipt,Journal,Contra,AllInvoice;
//         StartDate: Date;
//         EndDate: Date;
//         LocCode: Text;
//         ExportType: Option " ",Xml,JSON,TXT;
//         DocumentType: Text;
//         PostingDate: Text;
//         PartyCode: Text;
//         PartyName: Text;
//         PartyGSTRegType: Text;
//         PartyGSTRegNo: Text;
//         PartyStateCode: Text;
//         BillToAdress1: Text;
//         BillToAdress2: Text;
//         BillToAdress3: Text;
//         BillToAdress4: Text;
//         BillToStateCode: Text;
//         ShipToAdress1: Text;
//         ShipToAdress2: Text;
//         ShipToAdress3: Text;
//         ShipToAdress4: Text;
//         ShipToStateCode: Text;
//         ItemType: Text;
//         ItemCode: Text;
//         ItemName: Text;
//         ItemDesc: Text;
//         Quantity: Text;
//         UOM: Text;
//         UnitPrice: Text;
//         Discount: Text;
//         Amount: Text;
//         HSNCode: Text;
//         GSTRate: Text;
//         GSTBaseAmount: Decimal;
//         GSTAmount: Decimal;
//         NettAmount: Decimal;
//         XMLValues: Text;
//         CGSTAmount: Decimal;
//         SGSTAmount: Decimal;
//         IGSTAmount: Decimal;
//         CESSAmount: Decimal;
//         DiffAmount: Decimal;
//         Item: Record Item;
//         GLAcct: Record "G/L Account";
//         ItemQty: Text;
//         ILE: Record "Item Ledger Entry";
//         SalesAcctName: Text;
//         VarDoctNo: Text;
//         XMLHTTP: Automation;
//         XMLDoc: Automation;
//         TxtFile: File;
//         OutStreamObj: OutStream;
//         FileLoc: Text;
//         s: dotnet IBarcodeProvider;
//         LineAmount: Decimal;
//         OtherAmount: Decimal;
//         PrevKeyValues: Text;
//         CurrKeyValues: Text;
//         Cust: Record Customer;
//         GSTSetup: Record "GST Setup";
//         HSNRec: Record "HSN/SAC";
//         DotNetString: dotnet String;
//         LocRec: Record Location;
//         WinDialog: Dialog;
//         Text055: label '#1#################################\\Importing Data #2###########\\Document Type #3###########\\Document No #4###########\\Document Date #5###########\\Progress @6@@@@@@@@@@@@@@@@@@@@@@@@@\';
//         LineCount: Integer;
//         TotalInvoice: Integer;
//         CurrInvKeys: Text;
//         PrevInvKeys: Text;
//         TallyCompanyName: Text;
//         MasterNaming: Option "Code","Code-Name",Name;
//         MasterName: Text;
//         ProdGroup: Record "Product Group";
//         ProdCat: Record "Item Category";
//         VarCode: Text;
//         VarName: Text;
//         CHItem: Record "Item Charge";
//         FARec: Record "Fixed Asset";
//         ResRec: Record Resource;
//         RoundAcctNo: Text;
//         GLSetup: Record "General Ledger Setup";
//         CurrencyFactor: Decimal;
//         RoundAcctDesc: Text;
//         TallyLinkUrl: Text;
//         ExportMaster: Boolean;
//         ExportTransaction: Boolean;

//     local procedure SendDataToTally()
//     begin
//         if DoctType = Docttype::AllInvoice then
//             WinDialog.Open(Text055);

//         if GLAcct.Get(RoundAcctNo) then;
//         VarCode := GLAcct."No.";
//         VarName := GLAcct.Name;


//         if MasterNaming = Masternaming::Code then
//             RoundAcctDesc := VarCode
//         else
//             if MasterNaming = Masternaming::Name then
//                 RoundAcctDesc := VarName
//             else
//                 RoundAcctDesc := VarCode + '-' + VarName;

//         RoundAcctDesc := ConvertMasterName(RoundAcctDesc);


//         if (DoctType = Docttype::"Sales Invoice") or (DoctType = Docttype::AllInvoice) then begin
//             if DoctType <> Docttype::AllInvoice then
//                 WinDialog.Open(Text055);
//             WinDialog.Update(1, 'Processing Masters...');
//             WinDialog.Update(3, 'Sales Invoice');
//             if ExportMaster then
//                 ExportAllSalesInvoiceMasters;
//             if ExportTransaction then
//                 ExportSalesInvoiceTransaction;
//         end;

//         if (DoctType = Docttype::"Sales CrMemo") or (DoctType = Docttype::AllInvoice) then begin
//             if DoctType <> Docttype::AllInvoice then
//                 WinDialog.Open(Text055);
//             WinDialog.Update(1, 'Processing Masters...');
//             WinDialog.Update(3, 'Sales Credit Memo');
//             if ExportMaster then
//                 ExportAllSalesCrMemoMasters;
//             if ExportTransaction then
//                 ExportSalesCrMemoTransaction;
//         end;


//         if (DoctType = Docttype::"Purchase Invoice") or (DoctType = Docttype::AllInvoice) then begin
//             if DoctType <> Docttype::AllInvoice then
//                 WinDialog.Open(Text055);
//             WinDialog.Update(1, 'Processing Masters...');
//             WinDialog.Update(3, 'Purchase Invoice');
//             if ExportMaster then
//                 ExportAllPurchaseInvoiceMasters;
//             if ExportTransaction then
//                 ExportPurchaseInvoiceTransaction;
//         end;

//         if (DoctType = Docttype::"Purchase CrMemo") or (DoctType = Docttype::AllInvoice) then begin
//             if DoctType <> Docttype::AllInvoice then
//                 WinDialog.Open(Text055);
//             WinDialog.Update(1, 'Processing Masters...');
//             WinDialog.Update(3, 'Purchase Credit Memo');
//             if ExportMaster then
//                 ExportAllPurchaseCrMemoMasters;
//             if ExportTransaction then
//                 ExportPurchaseCrMemoTransaction;
//         end;

//         if (DoctType = Docttype::Payment) or (DoctType = Docttype::AllInvoice) then begin
//             if DoctType <> Docttype::AllInvoice then
//                 WinDialog.Open(Text055);
//             WinDialog.Update(1, 'Processing Masters...');
//             WinDialog.Update(3, 'Payment');
//             if ExportMaster then
//                 ExportAllPaymentMasters;
//             if ExportTransaction then
//                 ExportPaymentTransaction;
//         end;


//         if (DoctType = Docttype::Receipt) or (DoctType = Docttype::AllInvoice) then begin
//             if DoctType <> Docttype::AllInvoice then
//                 WinDialog.Open(Text055);
//             WinDialog.Update(1, 'Processing Masters...');
//             WinDialog.Update(3, 'Receipt');
//             if ExportMaster then
//                 ExportAllReceiptMasters;
//             if ExportTransaction then
//                 ExportReceiptTransaction;
//         end;


//         if (DoctType = Docttype::Journal) or (DoctType = Docttype::AllInvoice) then begin
//             if DoctType <> Docttype::AllInvoice then
//                 WinDialog.Open(Text055);
//             WinDialog.Update(1, 'Processing Masters...');
//             WinDialog.Update(3, 'Journal');
//             if ExportMaster then
//                 ExportAllJournalMasters;
//             if ExportTransaction then
//                 ExportJournalTransaction;
//         end;

//         if (DoctType = Docttype::Contra) or (DoctType = Docttype::AllInvoice) then begin
//             if DoctType <> Docttype::AllInvoice then
//                 WinDialog.Open(Text055);
//             WinDialog.Update(1, 'Processing Masters...');
//             WinDialog.Update(3, 'Contra');
//             if ExportMaster then
//                 ExportAllContraMasters;
//             if ExportTransaction then
//                 ExportContraTransaction;
//         end;
//     end;

//     local procedure AddExportString(FieldHeading: Text; FieldValue: Text)
//     begin
//         DotNetString := FieldValue;
//         DotNetString := DotNetString.Replace('&', '&amp; ');
//         DotNetString := DotNetString.Replace('Applicable', '&#4; Applicable');
//         DotNetString := DotNetString.Replace('Any', '&#4; Any');
//         FieldValue := DotNetString.ToString();

//         XMLValues := XMLValues + '<' + FieldHeading + '>' + FieldValue + '</' + FieldHeading + '>'
//     end;

//     local procedure AddExportValues(FieldValue: Text)
//     begin
//         XMLValues := XMLValues + FieldValue;
//     end;

//     local procedure ExportSalesInvoiceTransaction()
//     var
//         SIH3: Record "Sales Invoice Header";
//         SIH2: Record "Sales Invoice Header";
//     begin
//         LineCount := 0;

//         SIH3.Reset;
//         SIH3.SetCurrentkey("Posting Date");
//         SIH3.SetFilter("Location Code", LocCode);
//         SIH3.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             SIH3.SetFilter("No.", VarDoctNo);
//         TotalInvoice := SIH3.Count;

//         WinDialog.Update(1, 'Processing... ' + Format(TotalInvoice) + ' - Invoices');

//         if SIH3.FindFirst then
//             repeat
//                 CurrInvKeys := Format(SIH3."Posting Date");
//                 if CurrInvKeys <> PrevInvKeys then begin
//                     XMLValues := '';
//                     CreateTransactionXMLHeader;
//                     SIH2.Reset;
//                     SIH2.SetFilter("Location Code", LocCode);
//                     SIH2.SetRange("Posting Date", SIH3."Posting Date");
//                     if VarDoctNo <> '' then
//                         SIH2.SetFilter("No.", VarDoctNo);
//                     if SIH2.FindFirst then
//                         repeat
//                             LineCount := LineCount + 1;
//                             WinDialog.Update(2, Format(LineCount));
//                             WinDialog.Update(4, SIH2."No.");
//                             WinDialog.Update(5, SIH2."Posting Date");
//                             WinDialog.Update(6, ROUND(LineCount / TotalInvoice * 10000, 1));

//                             GenerateXMlDocForTallySalesInvoice(SIH2);

//                         until SIH2.Next = 0;
//                     CreateTransactionXMLFooter;
//                     CallPOSTService;
//                 end;
//                 PrevInvKeys := Format(SIH3."Posting Date");
//             until SIH3.Next = 0;
//     end;

//     local procedure ExportSalesCrMemoTransaction()
//     var
//         SCH3: Record "Sales Cr.Memo Header";
//         SCH2: Record "Sales Cr.Memo Header";
//     begin
//         LineCount := 0;

//         SCH3.Reset;
//         SCH3.SetCurrentkey("Posting Date");
//         SCH3.SetFilter("Location Code", LocCode);
//         SCH3.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             SCH3.SetFilter("No.", VarDoctNo);
//         TotalInvoice := SCH3.Count;

//         WinDialog.Update(1, 'Processing... ' + Format(TotalInvoice) + ' - Invoices');

//         if SCH3.FindFirst then
//             repeat
//                 CurrInvKeys := Format(SCH3."Posting Date");
//                 if CurrInvKeys <> PrevInvKeys then begin
//                     XMLValues := '';
//                     CreateTransactionXMLHeader;
//                     SCH2.Reset;
//                     SCH2.SetFilter("Location Code", LocCode);
//                     SCH2.SetRange("Posting Date", SCH3."Posting Date");
//                     if VarDoctNo <> '' then
//                         SCH2.SetFilter("No.", VarDoctNo);
//                     if SCH2.FindFirst then
//                         repeat
//                             LineCount := LineCount + 1;
//                             WinDialog.Update(2, Format(LineCount));
//                             WinDialog.Update(4, SCH2."No.");
//                             WinDialog.Update(5, SCH2."Posting Date");
//                             WinDialog.Update(6, ROUND(LineCount / TotalInvoice * 10000, 1));

//                             GenerateXMlDocForTallySalesCrMemo(SCH2);

//                         until SCH2.Next = 0;
//                     CreateTransactionXMLFooter;
//                     CallPOSTService;
//                 end;
//                 PrevInvKeys := Format(SCH3."Posting Date");
//             until SCH3.Next = 0;
//     end;

//     local procedure ExportPurchaseInvoiceTransaction()
//     var
//         PIH3: Record "Purch. Inv. Header";
//         PIH2: Record "Purch. Inv. Header";
//     begin
//         LineCount := 0;
//         CurrInvKeys := '';
//         PrevInvKeys := '';

//         PIH3.Reset;
//         PIH3.SetCurrentkey("Posting Date");
//         PIH3.SetFilter("Location Code", LocCode);
//         PIH3.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             PIH3.SetFilter("No.", VarDoctNo);
//         TotalInvoice := PIH3.Count;

//         WinDialog.Update(1, 'Processing... ' + Format(TotalInvoice) + ' - Invoices');

//         if PIH3.FindFirst then
//             repeat
//                 CurrInvKeys := Format(PIH3."Posting Date");
//                 if CurrInvKeys <> PrevInvKeys then begin
//                     XMLValues := '';
//                     CreateTransactionXMLHeader;
//                     PIH2.Reset;
//                     PIH2.SetFilter("Location Code", LocCode);
//                     PIH2.SetRange("Posting Date", PIH3."Posting Date");
//                     if VarDoctNo <> '' then
//                         PIH2.SetFilter("No.", VarDoctNo);
//                     if PIH2.FindFirst then
//                         repeat
//                             LineCount := LineCount + 1;
//                             WinDialog.Update(2, Format(LineCount));
//                             WinDialog.Update(4, PIH2."No.");
//                             WinDialog.Update(5, PIH2."Posting Date");
//                             WinDialog.Update(6, ROUND(LineCount / TotalInvoice * 10000, 1));

//                             GenerateXMlDocForTallyPurchaseInvoice(PIH2);

//                         until PIH2.Next = 0;
//                     CreateTransactionXMLFooter;
//                     CallPOSTService;
//                 end;
//                 PrevInvKeys := Format(PIH3."Posting Date");
//             until PIH3.Next = 0;
//     end;

//     local procedure ExportPurchaseCrMemoTransaction()
//     var
//         PCH3: Record "Purch. Cr. Memo Hdr.";
//         PCH2: Record "Purch. Cr. Memo Hdr.";
//     begin
//         LineCount := 0;
//         CurrInvKeys := '';
//         PrevInvKeys := '';

//         PCH3.Reset;
//         PCH3.SetCurrentkey("Posting Date");
//         PCH3.SetFilter("Location Code", LocCode);
//         PCH3.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             PCH3.SetFilter("No.", VarDoctNo);
//         TotalInvoice := PCH3.Count;

//         WinDialog.Update(1, 'Processing... ' + Format(TotalInvoice) + ' - Invoices');

//         if PCH3.FindFirst then
//             repeat
//                 CurrInvKeys := Format(PCH3."Posting Date");
//                 if CurrInvKeys <> PrevInvKeys then begin
//                     XMLValues := '';
//                     CreateTransactionXMLHeader;
//                     PCH2.Reset;
//                     PCH2.SetFilter("Location Code", LocCode);
//                     PCH2.SetRange("Posting Date", PCH3."Posting Date");
//                     if VarDoctNo <> '' then
//                         PCH2.SetFilter("No.", VarDoctNo);
//                     if PCH2.FindFirst then
//                         repeat
//                             LineCount := LineCount + 1;
//                             WinDialog.Update(2, Format(LineCount));
//                             WinDialog.Update(4, PCH2."No.");
//                             WinDialog.Update(5, PCH2."Posting Date");
//                             WinDialog.Update(6, ROUND(LineCount / TotalInvoice * 10000, 1));

//                             GenerateXMlDocForTallyPurchaseCrMemo(PCH2);

//                         until PCH2.Next = 0;
//                     CreateTransactionXMLFooter;
//                     CallPOSTService;
//                 end;
//                 PrevInvKeys := Format(PCH3."Posting Date");
//             until PCH3.Next = 0;
//     end;

//     local procedure ExportPaymentTransaction()
//     var
//         SIH3: Record "Sales Invoice Header";
//         SIH2: Record "Sales Invoice Header";
//         GJTemp: Record "Gen. Journal Template";
//         TemplateName: Text;
//         GLEntry3: Record "G/L Entry";
//         AllSourceCode: Text;
//         GLEntry2: Record "G/L Entry";
//         CurrDocValues: Text;
//         PrevDocValues: Text;
//     begin
//         LineCount := 0;
//         TemplateName := '';
//         AllSourceCode := '';
//         CurrInvKeys := '';
//         PrevInvKeys := '';
//         TotalInvoice := 0;

//         GJTemp.Reset;
//         GJTemp.SetFilter(GJTemp."Sub Type", '%1|%2', GJTemp."sub type"::"Cash Payment Voucher", GJTemp."sub type"::"Bank Payment Voucher");
//         GJTemp.SetFilter(Type, '%1|%2', GJTemp.Type::General, GJTemp.Type::Payments);
//         if GJTemp.FindFirst then
//             repeat
//                 if TemplateName = '' then
//                     TemplateName := GJTemp.Name
//                 else
//                     TemplateName := TemplateName + '|' + GJTemp.Name;

//                 if AllSourceCode = '' then
//                     AllSourceCode := GJTemp."Source Code"
//                 else
//                     AllSourceCode := AllSourceCode + '|' + GJTemp."Source Code";
//             until GJTemp.Next = 0;

//         CurrDocValues := '';
//         PrevDocValues := '';

//         GLEntry3.Reset;
//         GLEntry3.SetCurrentkey("Document No.");
//         GLEntry3.SetFilter("Source Code", AllSourceCode);
//         GLEntry3.SetRange("Posting Date", StartDate, EndDate);
//         //GLEntry3.SETFILTER("Location Code",LocCode);
//         if VarDoctNo <> '' then
//             GLEntry3.SetFilter("Document No.", VarDoctNo);
//         if GLEntry3.FindFirst then
//             repeat
//                 CurrDocValues := GLEntry3."Document No.";
//                 if CurrDocValues <> PrevDocValues then begin
//                     TotalInvoice := TotalInvoice + 1;
//                 end;
//                 PrevDocValues := GLEntry3."Document No.";
//             until GLEntry3.Next = 0;

//         WinDialog.Update(1, 'Processing... ' + Format(TotalInvoice) + ' - Invoices');

//         CurrDocValues := '';
//         PrevDocValues := '';
//         GLEntry3.Reset;
//         GLEntry3.SetCurrentkey("Posting Date");
//         GLEntry3.SetFilter("Source Code", AllSourceCode);
//         GLEntry3.SetRange("Posting Date", StartDate, EndDate);
//         //GLEntry3.SETFILTER("Location Code",LocCode);
//         if VarDoctNo <> '' then
//             GLEntry3.SetFilter("Document No.", VarDoctNo);
//         if GLEntry3.FindFirst then
//             repeat
//                 CurrInvKeys := Format(GLEntry3."Posting Date");
//                 if CurrInvKeys <> PrevInvKeys then begin
//                     XMLValues := '';
//                     CurrDocValues := '';
//                     PrevDocValues := '';
//                     CreateTransactionXMLHeader;

//                     GLEntry2.Reset;
//                     GLEntry2.SetCurrentkey("Document No.");
//                     //GLEntry2.SETFILTER("Location Code",LocCode);
//                     GLEntry2.SetFilter("Source Code", AllSourceCode);
//                     GLEntry2.SetRange("Posting Date", GLEntry3."Posting Date");
//                     if VarDoctNo <> '' then
//                         GLEntry2.SetFilter("Document No.", VarDoctNo);
//                     if GLEntry2.FindFirst then
//                         repeat
//                             CurrDocValues := GLEntry2."Document No.";
//                             if CurrDocValues <> PrevDocValues then begin
//                                 LineCount := LineCount + 1;
//                                 WinDialog.Update(2, Format(LineCount));
//                                 WinDialog.Update(4, GLEntry2."Document No.");
//                                 WinDialog.Update(5, GLEntry2."Posting Date");
//                                 WinDialog.Update(6, ROUND(LineCount / TotalInvoice * 10000, 1));

//                                 GenerateXMlDocForTallyPayment(LocCode, AllSourceCode, GLEntry2."Posting Date", GLEntry2."Document No.", 'Payment', 'Payment');

//                             end;
//                             PrevDocValues := GLEntry2."Document No.";
//                         until GLEntry2.Next = 0;
//                     CreateTransactionXMLFooter;
//                     CallPOSTService;
//                 end;
//                 PrevInvKeys := Format(GLEntry3."Posting Date");
//             until GLEntry3.Next = 0;
//     end;

//     local procedure ExportReceiptTransaction()
//     var
//         SIH3: Record "Sales Invoice Header";
//         SIH2: Record "Sales Invoice Header";
//         GJTemp: Record "Gen. Journal Template";
//         TemplateName: Text;
//         GLEntry3: Record "G/L Entry";
//         AllSourceCode: Text;
//         GLEntry2: Record "G/L Entry";
//         CurrDocValues: Text;
//         PrevDocValues: Text;
//     begin
//         LineCount := 0;
//         TemplateName := '';
//         AllSourceCode := '';
//         CurrInvKeys := '';
//         PrevInvKeys := '';
//         TotalInvoice := 0;

//         GJTemp.Reset;
//         GJTemp.SetFilter(GJTemp."Sub Type", '%1|%2', GJTemp."sub type"::"Cash Receipt Voucher", GJTemp."sub type"::"Bank Receipt Voucher");
//         GJTemp.SetFilter(Type, '%1|%2', GJTemp.Type::General, GJTemp.Type::"Cash Receipts");
//         if GJTemp.FindFirst then
//             repeat
//                 if AllSourceCode = '' then
//                     AllSourceCode := GJTemp."Source Code"
//                 else
//                     AllSourceCode := AllSourceCode + '|' + GJTemp."Source Code";
//             until GJTemp.Next = 0;

//         CurrDocValues := '';
//         PrevDocValues := '';

//         GLEntry3.Reset;
//         GLEntry3.SetCurrentkey("Document No.");
//         GLEntry3.SetFilter("Source Code", AllSourceCode);
//         GLEntry3.SetRange("Posting Date", StartDate, EndDate);
//         //GLEntry3.SETFILTER("Location Code",LocCode);
//         if VarDoctNo <> '' then
//             GLEntry3.SetFilter("Document No.", VarDoctNo);
//         if GLEntry3.FindFirst then
//             repeat
//                 CurrDocValues := GLEntry3."Document No.";
//                 if CurrDocValues <> PrevDocValues then begin
//                     TotalInvoice := TotalInvoice + 1;
//                 end;
//                 PrevDocValues := GLEntry3."Document No.";
//             until GLEntry3.Next = 0;

//         WinDialog.Update(1, 'Processing... ' + Format(TotalInvoice) + ' - Invoices');

//         CurrDocValues := '';
//         PrevDocValues := '';
//         GLEntry3.Reset;
//         GLEntry3.SetCurrentkey("Posting Date");
//         GLEntry3.SetFilter("Source Code", AllSourceCode);
//         GLEntry3.SetRange("Posting Date", StartDate, EndDate);
//         //GLEntry3.SETFILTER("Location Code",LocCode);
//         if VarDoctNo <> '' then
//             GLEntry3.SetFilter("Document No.", VarDoctNo);
//         if GLEntry3.FindFirst then
//             repeat
//                 CurrInvKeys := Format(GLEntry3."Posting Date");
//                 if CurrInvKeys <> PrevInvKeys then begin
//                     XMLValues := '';
//                     CurrDocValues := '';
//                     PrevDocValues := '';
//                     CreateTransactionXMLHeader;

//                     GLEntry2.Reset;
//                     GLEntry2.SetCurrentkey("Document No.");
//                     //GLEntry2.SETFILTER("Location Code",LocCode);
//                     GLEntry2.SetFilter("Source Code", AllSourceCode);
//                     GLEntry2.SetRange("Posting Date", GLEntry3."Posting Date");
//                     if VarDoctNo <> '' then
//                         GLEntry2.SetFilter("Document No.", VarDoctNo);
//                     if GLEntry2.FindFirst then
//                         repeat
//                             CurrDocValues := GLEntry2."Document No.";
//                             if CurrDocValues <> PrevDocValues then begin
//                                 LineCount := LineCount + 1;
//                                 WinDialog.Update(2, Format(LineCount));
//                                 WinDialog.Update(4, GLEntry2."Document No.");
//                                 WinDialog.Update(5, GLEntry2."Posting Date");
//                                 WinDialog.Update(6, ROUND(LineCount / TotalInvoice * 10000, 1));

//                                 GenerateXMlDocForTallyReceipt(LocCode, AllSourceCode, GLEntry2."Posting Date", GLEntry2."Document No.", 'Receipt', 'Receipt');

//                             end;
//                             PrevDocValues := GLEntry2."Document No.";
//                         until GLEntry2.Next = 0;
//                     CreateTransactionXMLFooter;
//                     CallPOSTService;
//                 end;
//                 PrevInvKeys := Format(GLEntry3."Posting Date");
//             until GLEntry3.Next = 0;
//     end;

//     local procedure ExportJournalTransaction()
//     var
//         SIH3: Record "Sales Invoice Header";
//         SIH2: Record "Sales Invoice Header";
//         GJTemp: Record "Gen. Journal Template";
//         TemplateName: Text;
//         GLEntry3: Record "G/L Entry";
//         AllSourceCode: Text;
//         GLEntry2: Record "G/L Entry";
//         CurrDocValues: Text;
//         PrevDocValues: Text;
//     begin
//         LineCount := 0;
//         TemplateName := '';
//         AllSourceCode := '';
//         CurrInvKeys := '';
//         PrevInvKeys := '';
//         TotalInvoice := 0;
//         AllSourceCode := 'REVERSAL';

//         GJTemp.Reset;
//         GJTemp.SetFilter(GJTemp."Sub Type", '%1', GJTemp."sub type"::"Journal Voucher");
//         GJTemp.SetFilter(Type, '%1', GJTemp.Type::General);
//         if GJTemp.FindFirst then
//             repeat
//                 if AllSourceCode = '' then
//                     AllSourceCode := GJTemp."Source Code"
//                 else
//                     AllSourceCode := AllSourceCode + '|' + GJTemp."Source Code";
//             until GJTemp.Next = 0;

//         CurrDocValues := '';
//         PrevDocValues := '';

//         GLEntry3.Reset;
//         GLEntry3.SetCurrentkey("Document No.");
//         GLEntry3.SetFilter("Source Code", AllSourceCode);
//         GLEntry3.SetRange("Posting Date", StartDate, EndDate);
//         //GLEntry3.SETFILTER("Location Code",LocCode);
//         if VarDoctNo <> '' then
//             GLEntry3.SetFilter("Document No.", VarDoctNo);
//         if GLEntry3.FindFirst then
//             repeat
//                 CurrDocValues := GLEntry3."Document No.";
//                 if CurrDocValues <> PrevDocValues then begin
//                     TotalInvoice := TotalInvoice + 1;
//                 end;
//                 PrevDocValues := GLEntry3."Document No.";
//             until GLEntry3.Next = 0;

//         WinDialog.Update(1, 'Processing... ' + Format(TotalInvoice) + ' - Invoices');

//         CurrDocValues := '';
//         PrevDocValues := '';
//         GLEntry3.Reset;
//         GLEntry3.SetCurrentkey("Posting Date");
//         GLEntry3.SetFilter("Source Code", AllSourceCode);
//         GLEntry3.SetRange("Posting Date", StartDate, EndDate);
//         //GLEntry3.SETFILTER("Location Code",LocCode);
//         if VarDoctNo <> '' then
//             GLEntry3.SetFilter("Document No.", VarDoctNo);
//         if GLEntry3.FindFirst then
//             repeat
//                 CurrInvKeys := Format(GLEntry3."Posting Date");
//                 if CurrInvKeys <> PrevInvKeys then begin
//                     XMLValues := '';
//                     CurrDocValues := '';
//                     PrevDocValues := '';
//                     CreateTransactionXMLHeader;

//                     GLEntry2.Reset;
//                     GLEntry2.SetCurrentkey("Document No.");
//                     //GLEntry2.SETFILTER("Location Code",LocCode);
//                     GLEntry2.SetFilter("Source Code", AllSourceCode);
//                     GLEntry2.SetRange("Posting Date", GLEntry3."Posting Date");
//                     if VarDoctNo <> '' then
//                         GLEntry2.SetFilter("Document No.", VarDoctNo);
//                     if GLEntry2.FindFirst then
//                         repeat
//                             CurrDocValues := GLEntry2."Document No.";
//                             if CurrDocValues <> PrevDocValues then begin
//                                 LineCount := LineCount + 1;
//                                 WinDialog.Update(2, Format(LineCount));
//                                 WinDialog.Update(4, GLEntry2."Document No.");
//                                 WinDialog.Update(5, GLEntry2."Posting Date");
//                                 WinDialog.Update(6, ROUND(LineCount / TotalInvoice * 10000, 1));

//                                 GenerateXMlDocForTallyJournal(LocCode, AllSourceCode, GLEntry2."Posting Date", GLEntry2."Document No.", 'Journal', 'Journal');

//                             end;
//                             PrevDocValues := GLEntry2."Document No.";
//                         until GLEntry2.Next = 0;
//                     CreateTransactionXMLFooter;
//                     CallPOSTService;
//                 end;
//                 PrevInvKeys := Format(GLEntry3."Posting Date");
//             until GLEntry3.Next = 0;
//     end;

//     local procedure ExportContraTransaction()
//     var
//         SIH3: Record "Sales Invoice Header";
//         SIH2: Record "Sales Invoice Header";
//         GJTemp: Record "Gen. Journal Template";
//         TemplateName: Text;
//         GLEntry3: Record "G/L Entry";
//         AllSourceCode: Text;
//         GLEntry2: Record "G/L Entry";
//         CurrDocValues: Text;
//         PrevDocValues: Text;
//     begin
//         LineCount := 0;
//         TemplateName := '';
//         AllSourceCode := '';
//         CurrInvKeys := '';
//         PrevInvKeys := '';
//         TotalInvoice := 0;


//         GJTemp.Reset;
//         GJTemp.SetFilter(GJTemp."Sub Type", '%1', GJTemp."sub type"::"Contra Voucher");
//         GJTemp.SetFilter(Type, '%1', GJTemp.Type::General);
//         if GJTemp.FindFirst then
//             repeat
//                 if AllSourceCode = '' then
//                     AllSourceCode := GJTemp."Source Code"
//                 else
//                     AllSourceCode := AllSourceCode + '|' + GJTemp."Source Code";
//             until GJTemp.Next = 0;

//         CurrDocValues := '';
//         PrevDocValues := '';

//         GLEntry3.Reset;
//         GLEntry3.SetCurrentkey("Document No.");
//         GLEntry3.SetFilter("Source Code", AllSourceCode);
//         GLEntry3.SetRange("Posting Date", StartDate, EndDate);
//         //GLEntry3.SETFILTER("Location Code",LocCode);
//         if VarDoctNo <> '' then
//             GLEntry3.SetFilter("Document No.", VarDoctNo);
//         if GLEntry3.FindFirst then
//             repeat
//                 CurrDocValues := GLEntry3."Document No.";
//                 if CurrDocValues <> PrevDocValues then begin
//                     TotalInvoice := TotalInvoice + 1;
//                 end;
//                 PrevDocValues := GLEntry3."Document No.";
//             until GLEntry3.Next = 0;

//         WinDialog.Update(1, 'Processing... ' + Format(TotalInvoice) + ' - Invoices');

//         CurrDocValues := '';
//         PrevDocValues := '';
//         GLEntry3.Reset;
//         GLEntry3.SetCurrentkey("Posting Date");
//         GLEntry3.SetFilter("Source Code", AllSourceCode);
//         GLEntry3.SetRange("Posting Date", StartDate, EndDate);
//         //GLEntry3.SETFILTER("Location Code",LocCode);
//         if VarDoctNo <> '' then
//             GLEntry3.SetFilter("Document No.", VarDoctNo);
//         if GLEntry3.FindFirst then
//             repeat
//                 CurrInvKeys := Format(GLEntry3."Posting Date");
//                 if CurrInvKeys <> PrevInvKeys then begin
//                     XMLValues := '';
//                     CurrDocValues := '';
//                     PrevDocValues := '';
//                     CreateTransactionXMLHeader;

//                     GLEntry2.Reset;
//                     GLEntry2.SetCurrentkey("Document No.");
//                     //GLEntry2.SETFILTER("Location Code",LocCode);
//                     GLEntry2.SetFilter("Source Code", AllSourceCode);
//                     GLEntry2.SetRange("Posting Date", GLEntry3."Posting Date");
//                     if VarDoctNo <> '' then
//                         GLEntry2.SetFilter("Document No.", VarDoctNo);
//                     if GLEntry2.FindFirst then
//                         repeat
//                             CurrDocValues := GLEntry2."Document No.";
//                             if CurrDocValues <> PrevDocValues then begin
//                                 LineCount := LineCount + 1;
//                                 WinDialog.Update(2, Format(LineCount));
//                                 WinDialog.Update(4, GLEntry2."Document No.");
//                                 WinDialog.Update(5, GLEntry2."Posting Date");
//                                 WinDialog.Update(6, ROUND(LineCount / TotalInvoice * 10000, 1));

//                                 GenerateXMlDocForTallyContra(LocCode, AllSourceCode, GLEntry2."Posting Date", GLEntry2."Document No.", 'Contra', 'Contra');

//                             end;
//                             PrevDocValues := GLEntry2."Document No.";
//                         until GLEntry2.Next = 0;
//                     CreateTransactionXMLFooter;
//                     CallPOSTService;
//                 end;
//                 PrevInvKeys := Format(GLEntry3."Posting Date");
//             until GLEntry3.Next = 0;
//     end;

//     local procedure GenerateExpLines(InDocType: Option ,"Sales Invoice","Sales CrMemo","Purchase Invoice","Purchase CrMemo","Transfer Shipment","Transfer Receipt","Service Invoice","Service CrMemo"; InDocNo: Text)
//     var
//         SIH: Record "Sales Invoice Header";
//         SIL: Record "Sales Invoice Line";
//         SIH2: Record "Sales Invoice Header";
//     begin

//         if InDocType = Indoctype::"Sales Invoice" then begin
//             SIH.Get(InDocNo);
//             SIL.Reset;
//             SIL.SetRange("Document No.", InDocNo);
//             if SIL.FindFirst then
//                 repeat
//                     DocumentType := SIH2."No.";
//                     PostingDate := Format(SIH."Posting Date");
//                     PartyCode := SIH."Sell-to Customer No.";
//                     PartyName := SIH."Sell-to Customer Name";
//                     // PartyGSTRegType:=
//                     PartyGSTRegNo := SIH."Customer GST Reg. No.";
//                     PartyStateCode := SIH.State;
//                     BillToAdress1 := SIH."Sell-to Customer Name";
//                     BillToAdress2 := SIH."Sell-to Customer Name";
//                     BillToAdress3 := SIH."Sell-to Customer Name";
//                     BillToAdress4 := SIH."Sell-to Customer Name";
//                     BillToStateCode := SIH."Sell-to Customer Name";
//                     ShipToAdress1 := SIH."Sell-to Customer Name";
//                     ShipToAdress2 := SIH."Sell-to Customer Name";
//                     ShipToAdress3 := SIH."Sell-to Customer Name";
//                     ShipToAdress4 := SIH."Sell-to Customer Name";
//                     ShipToStateCode := SIH."Sell-to Customer Name";

//                     ItemType := Format(SIL.Type);
//                     ItemCode := SIL."No.";
//                     ItemName := SIL.Description;
//                     ItemDesc := SIL."Description 2";
//                     Quantity := Format(SIL.Quantity);
//                     UOM := SIL."Unit of Measure Code";
//                     UnitPrice := Format(SIL."Unit Price");
//                     Discount := Format(SIL."Line Discount %");
//                     Amount := Format(SIL."Line Amount");
//                     HSNCode := SIL."HSN/SAC Code";
//                     GSTRate := Format(SIL."GST %");
//                     GSTBaseAmount := SIL."GST Base Amount";
//                     GSTAmount := SIL."Total GST Amount";
//                     NettAmount := SIL."Amount To Customer";

//                     CreateExportDoc;
//                 until SIL.Next = 0;
//         end;
//     end;

//     local procedure CreateExportDoc()
//     var
//         SIH: Record "Sales Invoice Header";
//         SIL: Record "Sales Invoice Line";
//     begin

//         AddExportString('DocumentType', SIH."No.");
//         AddExportString('PostingDate', Format(SIH."Posting Date"));
//         AddExportString('PartyCode', SIH."Sell-to Customer No.");
//         AddExportString('PartyName', SIH."Sell-to Customer Name");
//         AddExportString('PartyGSTRegType', SIH."Sell-to Customer Name");
//         AddExportString('PartyGSTRegNo', SIH."Sell-to Customer Name");
//         AddExportString('PartyStateCode', SIH."Sell-to Customer Name");
//         AddExportString('BillToAdress1', SIH."Sell-to Customer Name");
//         AddExportString('BillToAdress2', SIH."Sell-to Customer Name");
//         AddExportString('BillToAdress3', SIH."Sell-to Customer Name");
//         AddExportString('BillToAdress4', SIH."Sell-to Customer Name");
//         AddExportString('BillToStateCode', SIH."Sell-to Customer Name");
//         AddExportString('ShipToAdress1', SIH."Sell-to Customer Name");
//         AddExportString('ShipToAdress2', SIH."Sell-to Customer Name");
//         AddExportString('ShipToAdress3', SIH."Sell-to Customer Name");
//         AddExportString('ShipToAdress4', SIH."Sell-to Customer Name");
//         AddExportString('ShipToStateCode', SIH."Sell-to Customer Name");

//         AddExportString('ItemType', Format(SIL.Type));
//         AddExportString('ItemCode', SIL."No.");
//         AddExportString('ItemName', SIL.Description);
//         AddExportString('ItemDesc', SIL."Description 2");
//         AddExportString('Quantity', Format(SIL.Quantity));
//         AddExportString('UOM', SIL."Unit of Measure Code");
//         AddExportString('UnitPrice', Format(SIL."Unit Price"));
//         AddExportString('Discount', Format(SIL."Line Discount %"));
//         AddExportString('Amount', Format(SIL."Line Amount"));
//         AddExportString('HSNCode', SIL."HSN/SAC Code");
//         AddExportString('GSTRate', Format(SIL."GST %"));
//         AddExportString('GSTBaseAmount', Format(SIL."GST Base Amount"));
//         AddExportString('GSTAmount', Format(SIL."Total GST Amount"));
//         AddExportString('NettAmount', Format(SIL."Amount To Customer"));
//     end;

//     local procedure GenerateXMlDocForTallySalesInvoice(SIH: Record "Sales Invoice Header")
//     var
//         SIL: Record "Sales Invoice Line";
//         RoundAcctName: Text;
//         RoundAcctAmount: Decimal;
//         JsType: Text;
//         GSTGroup: Record "GST Group";
//     begin
//         XMLValues := XMLValues + '<VOUCHER VCHTYPE="Sales" ACTION="Create" OBJVIEW="Invoice Voucher View">';

//         CurrencyFactor := GETCurrFactor(SIH."Currency Factor");
//         JsType := '';
//         LineAmount := 0;
//         GSTAmount := 0;
//         GSTBaseAmount := 0;
//         NettAmount := 0;
//         RoundAcctAmount := 0;
//         RoundAcctName := RoundAcctDesc;

//         SIL.Reset;
//         SIL.SetRange("Document No.", SIH."No.");
//         SIL.SetFilter("No.", '<>%1', '');
//         if SIL.FindFirst then
//             repeat
//                 if JsType = '' then
//                     JsType := Format(SIL."GST Jurisdiction Type");

//                 if RoundAcctNo = SIL."No." then begin
//                     RoundAcctAmount := RoundAcctAmount + ROUND(SIL.Amount / CurrencyFactor, 0.01);
//                 end;

//                 LineAmount := LineAmount + ROUND(SIL.Amount / CurrencyFactor, 0.01);
//                 GSTAmount := GSTAmount + SIL."Total GST Amount";
//                 GSTBaseAmount := GSTBaseAmount + SIL."GST Base Amount";
//                 NettAmount := NettAmount + SIL."Amount To Customer";
//             until SIL.Next = 0;

//         GSTAmount := ROUND(GSTAmount / CurrencyFactor, 0.01);
//         GSTBaseAmount := ROUND(GSTBaseAmount / CurrencyFactor, 0.01);
//         NettAmount := ROUND(NettAmount / CurrencyFactor, 0.01);

//         IGSTAmount := 0;
//         CGSTAmount := 0;
//         SGSTAmount := 0;
//         CESSAmount := 0;

//         if JsType = 'Interstate' then begin
//             IGSTAmount := GSTAmount;
//             CESSAmount := 0;
//         end else begin
//             CGSTAmount := GSTAmount / 2;
//             CGSTAmount := ROUND(CGSTAmount, 0.01);
//             SGSTAmount := CGSTAmount;
//             CESSAmount := 0;
//         end;

//         OtherAmount := NettAmount - (LineAmount + CGSTAmount + SGSTAmount + IGSTAmount + CESSAmount);
//         //OtherAmount:=(LineAmount+CGSTAmount+SGSTAmount+IGSTAmount+CESSAmount)-NettAmount;


//         if (OtherAmount > -1) and (OtherAmount < 1) then begin
//             RoundAcctAmount := RoundAcctAmount + OtherAmount;
//             OtherAmount := 0;
//         end;

//         //MESSAGE(RoundAcctName+'-'+FORMAT(NettAmount)+'-'+FORMAT(LineAmount)+'-'+FORMAT(CGSTAmount+SGSTAmount+IGSTAmount+CESSAmount)+'-'+FORMAT(RoundAcctAmount)+'-'+FORMAT(OtherAmount));


//         if SIH."Bill-to Address" <> '' then begin
//             XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//             AddExportString('ADDRESS', SIH."Sell-to Address");
//             AddExportString('ADDRESS', SIH."Sell-to Address 2");
//             AddExportString('ADDRESS', SIH."Sell-to City" + '-' + SIH."Sell-to Post Code");
//             XMLValues := XMLValues + '</ADDRESS.LIST>';
//         end;

//         if SIH."Ship-to Address" <> '' then begin
//             XMLValues := XMLValues + '<BASICBUYERADDRESS.LIST TYPE="String">';
//             AddExportString('BASICBUYERADDRESS', SIH."Sell-to Address");
//             AddExportString('BASICBUYERADDRESS', SIH."Sell-to Address 2");
//             AddExportString('BASICBUYERADDRESS', SIH."Sell-to City" + '-' + SIH."Sell-to Post Code");
//             XMLValues := XMLValues + '</BASICBUYERADDRESS.LIST>';
//         end;

//         XMLValues := XMLValues + '<BASICORDERTERMS.LIST TYPE="String">';
//         AddExportString('BASICORDERTERMS', SIH."Shipment Method Code");
//         XMLValues := XMLValues + '</BASICORDERTERMS.LIST>';

//         Cust.Get(SIH."Sell-to Customer No.");

//         MasterName := '';
//         if MasterNaming = Masternaming::Code then
//             MasterName := SIH."Sell-to Customer No."
//         else
//             if MasterNaming = Masternaming::Name then
//                 MasterName := Cust.Name
//             else
//                 MasterName := SIH."Sell-to Customer No." + '-' + Cust.Name;

//         MasterName := ConvertMasterName(MasterName);

//         AddExportString('DATE', ConvertTallyDate(SIH."Posting Date"));
//         AddExportString('EFFECTIVEDATE', ConvertTallyDate(SIH."Posting Date"));
//         AddExportString('BILLOFLADINGDATE', ConvertTallyDate(SIH."LR/RR Date"));
//         AddExportString('STATENAME', GETTallyStateName(SIH."GST Ship-to State Code"));
//         AddExportString('GSTREGISTRATIONTYPE', Format(SIH."GST Customer Type"));
//         AddExportString('NARRATION', Format(SIH."External Document No."));
//         AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(SIH."Sell-to Country/Region Code"));
//         AddExportString('CONSIGNEEGSTIN', SIH."Ship-to GST Reg. No.");
//         AddExportString('PARTYGSTIN', SIH."Ship-to GST Reg. No.");
//         AddExportString('PARTYNAME', MasterName);
//         AddExportString('VOUCHERTYPENAME', 'Sales');
//         AddExportString('REFERENCE', SIH."Order No.");
//         AddExportString('VOUCHERNUMBER', SIH."No.");
//         AddExportString('PARTYLEDGERNAME', MasterName);
//         AddExportString('BASICBASEPARTYNAME', MasterName);
//         AddExportString('PERSISTEDVIEW', 'Invoice Voucher View');
//         AddExportString('BILLOFLADINGNO', SIH."LR/RR No.");
//         AddExportString('PLACEOFSUPPLY', GETTallyStateName(SIH."GST Ship-to State Code"));
//         AddExportString('BASICSHIPPEDBY', SIH."Shipping Agent Code");
//         AddExportString('BASICBUYERNAME', MasterName);
//         AddExportString('BASICSHIPDOCUMENTNO', SIH."External Document No.");
//         AddExportString('BASICFINALDESTINATION', SIH."Sell-to City");
//         AddExportString('BASICORDERREF', SIH."Order No.");
//         AddExportString('BASICSHIPVESSELNO', SIH."Vehicle No.");
//         AddExportString('BASICDUEDATEOFPYMT', ConvertTallyDate(SIH."Due Date"));
//         AddExportString('BASICDATETIMEOFINVOICE', ConvertTallyDate(SIH."Document Date"));
//         AddExportString('BASICDATETIMEOFREMOVAL', Format(SIH."Time of Removal"));
//         AddExportString('CONSIGNEESTATENAME', GETTallyStateName(SIH."GST Ship-to State Code"));
//         AddExportString('ENTEREDBY', SIH."User ID");
//         AddExportString('ISINVOICE', 'Yes');
//         /*
//         XMLValues:=XMLValues+'<INVOICEORDERLIST.LIST>';
//         AddExportString('BASICPURCHASEORDERNO',SIH."Order No.");
//         AddExportString('BASICORDERDATE',ConvertTallyDate(SIH."Order Date"));
//         XMLValues:=XMLValues+'</INVOICEORDERLIST.LIST>';
//         */

//         XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//         AddExportString('LEDGERNAME', MasterName);
//         AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//         AddExportString('ISPARTYLEDGER', 'Yes');
//         AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//         AddExportString('AMOUNT', Format(-NettAmount));
//         AddExportValues('<BILLALLOCATIONS.LIST>');
//         AddExportString('NAME', SIH."No.");
//         AddExportString('BILLCREDITPERIOD', SIH."No.");
//         AddExportString('BILLTYPE', 'New Ref');
//         AddExportString('AMOUNT', Format(-NettAmount));
//         AddExportValues('</BILLALLOCATIONS.LIST>');
//         XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';

//         SIL.Reset;
//         SIL.SetRange("Document No.", SIH."No.");
//         SIL.SetFilter("No.", '<>%1', '');
//         if SIL.FindFirst then
//             repeat
//                 SIL.Amount := ROUND(SIL.Amount / CurrencyFactor, 0.01);

//                 if SIL.Type <> SIL.Type::Item then begin
//                     MasterName := '';
//                     VarCode := '';
//                     VarName := '';

//                     if SIL.Type = SIL.Type::"G/L Account" then begin
//                         if GLAcct.Get(SIL."No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                     end;

//                     if SIL.Type = SIL.Type::"Charge (Item)" then begin
//                         if CHItem.Get(SIL."No.") then;
//                         VarCode := CHItem."No.";
//                         VarName := CHItem.Description;
//                     end;

//                     if SIL.Type = SIL.Type::"Fixed Asset" then begin
//                         if FARec.Get(SIL."No.") then;
//                         VarCode := FARec."No.";
//                         VarName := FARec.Description;
//                     end;

//                     if SIL.Type = SIL.Type::Resource then begin
//                         if ResRec.Get(SIL."No.") then;
//                         VarCode := ResRec."No.";
//                         VarName := ResRec.Name;
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);

//                     if RoundAcctNo = SIL."No." then begin
//                         RoundAcctName := MasterName;
//                         //RoundAcctAmount:=RoundAcctAmount+SIL.Amount;
//                     end else begin
//                         XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//                         AddExportString('LEDGERNAME', MasterName);
//                         AddExportString('ISDEEMEDPOSITIVE', 'No');
//                         AddExportString('ISPARTYLEDGER', 'No');
//                         AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                         AddExportString('AMOUNT', Format(SIL.Amount));
//                         XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//                     end;
//                 end else begin
//                     Item.Get(SIL."No.");

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Item."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Item.Description
//                         else
//                             MasterName := Item."No." + '-' + Item.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     ItemQty := ' ' + Format(SIL.Quantity) + ' ' + SIL."Unit of Measure Code";

//                     XMLValues := XMLValues + '<ALLINVENTORYENTRIES.LIST>';
//                     AddExportString('STOCKITEMNAME', MasterName);
//                     AddExportString('ISDEEMEDPOSITIVE', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                     AddExportString('RATE', Format(SIL."Unit Price"));
//                     AddExportString('DISCOUNT', Format(SIL."Line Discount %"));
//                     AddExportString('AMOUNT', Format(SIL.Amount));
//                     AddExportString('ACTUALQTY', ItemQty);
//                     AddExportString('BILLEDQTY', ItemQty);

//                     XMLValues := XMLValues + '<BATCHALLOCATIONS.LIST>';
//                     AddExportString('GODOWNNAME', GETGodownName(SIL."Location Code"));

//                     AddExportString('BATCHNAME', 'Primary Batch');
//                     AddExportString('DESTINATIONGODOWNNAME', GETGodownName(SIL."Location Code"));
//                     //AddExportString('INDENTNO',SIL.Description);
//                     //AddExportString('ORDERNO',SIH."Order No.");
//                     //AddExportString('TRACKINGNUMBER',SIL.Description);
//                     AddExportString('AMOUNT', Format(SIL.Amount));
//                     AddExportString('ACTUALQTY', ItemQty);
//                     AddExportString('BILLEDQTY', ItemQty);
//                     XMLValues := XMLValues + '</BATCHALLOCATIONS.LIST>';

//                     if GSTGroup.Get(SIL."GST Group Code") then
//                         SalesAcctName := 'Sales @ ' + Format(ROUND(GSTGroup."Tax Rate", 0.1)) + '%'
//                     else
//                         SalesAcctName := 'Sales @ 0%';

//                     XMLValues := XMLValues + '<ACCOUNTINGALLOCATIONS.LIST>';
//                     AddExportString('LEDGERNAME', SalesAcctName);
//                     AddExportString('ISDEEMEDPOSITIVE', 'No');
//                     AddExportString('ISPARTYLEDGER', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                     AddExportString('AMOUNT', Format(SIL.Amount));

//                     /*
//                     XMLValues:=XMLValues+'<CATEGORYALLOCATIONS.LIST>';
//                     AddExportString('CATEGORY',SIL.Description);
//                     AddExportString('ISDEEMEDPOSITIVE','No');
//                     XMLValues:=XMLValues+'<COSTCENTREALLOCATIONS.LIST>';
//                     AddExportString('NAME',SIL.Description);
//                     AddExportString('AMOUNT',SIL.Description);
//                     XMLValues:=XMLValues+'</COSTCENTREALLOCATIONS.LIST>';
//                     XMLValues:=XMLValues+'</CATEGORYALLOCATIONS.LIST>';
//                     */

//                     XMLValues := XMLValues + '</ACCOUNTINGALLOCATIONS.LIST>';
//                     XMLValues := XMLValues + '</ALLINVENTORYENTRIES.LIST>';

//                 end;
//             until SIL.Next = 0;

//         if OtherAmount <> 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'OTHER');
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(OtherAmount));
//             AddExportString('VATEXPAMOUNT', Format(OtherAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if CGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'CGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(CGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(CGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if SGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'SGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(SGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(SGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if IGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'IGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(IGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(IGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if CESSAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'CESS');
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(CESSAmount));
//             AddExportString('VATEXPAMOUNT', Format(CESSAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;


//         if RoundAcctAmount <> 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', RoundAcctName);
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(RoundAcctAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         XMLValues := XMLValues + '</VOUCHER>';

//     end;

//     local procedure GenerateXMlDocForTallySalesCrMemo(SCH: Record "Sales Cr.Memo Header")
//     var
//         SCL: Record "Sales Cr.Memo Line";
//         RoundAcctName: Text;
//         RoundAcctAmount: Decimal;
//         JsType: Text;
//         GSTGroup: Record "GST Group";
//     begin
//         XMLValues := XMLValues + '<VOUCHER VCHTYPE="Credit Note" ACTION="Create" OBJVIEW="Invoice Voucher View">';

//         CurrencyFactor := GETCurrFactor(SCH."Currency Factor");
//         JsType := '';
//         LineAmount := 0;
//         GSTAmount := 0;
//         GSTBaseAmount := 0;
//         NettAmount := 0;
//         RoundAcctAmount := 0;
//         RoundAcctName := RoundAcctDesc;

//         SCL.Reset;
//         SCL.SetRange("Document No.", SCH."No.");
//         SCL.SetFilter("No.", '<>%1', '');
//         if SCL.FindFirst then
//             repeat
//                 if JsType = '' then
//                     JsType := Format(SCL."GST Jurisdiction Type");

//                 LineAmount := LineAmount + ROUND(SCL.Amount / CurrencyFactor, 0.01);
//                 GSTAmount := GSTAmount + SCL."Total GST Amount";
//                 GSTBaseAmount := GSTBaseAmount + SCL."GST Base Amount";
//                 NettAmount := NettAmount + SCL."Amount To Customer";
//             until SCL.Next = 0;

//         GSTAmount := ROUND(GSTAmount / CurrencyFactor, 0.01);
//         GSTBaseAmount := ROUND(GSTBaseAmount / CurrencyFactor, 0.01);
//         NettAmount := ROUND(NettAmount / CurrencyFactor, 0.01);

//         IGSTAmount := 0;
//         CGSTAmount := 0;
//         SGSTAmount := 0;
//         CESSAmount := 0;
//         //OtherAmount:=NettAmount-(LineAmount+GSTAmount);

//         if JsType = 'Interstate' then begin
//             IGSTAmount := GSTAmount;
//             CESSAmount := 0;
//         end else begin
//             CGSTAmount := GSTAmount / 2;
//             CGSTAmount := ROUND(CGSTAmount, 0.01);
//             SGSTAmount := CGSTAmount;
//             CESSAmount := 0;
//         end;

//         OtherAmount := NettAmount - (LineAmount + CGSTAmount + SGSTAmount + IGSTAmount + CESSAmount);

//         if (OtherAmount > -1) and (OtherAmount < 1) then begin
//             RoundAcctAmount := RoundAcctAmount + OtherAmount;
//             OtherAmount := 0;
//         end;

//         if SCH."Bill-to Address" <> '' then begin
//             XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//             AddExportString('ADDRESS', SCH."Sell-to Address");
//             AddExportString('ADDRESS', SCH."Sell-to Address 2");
//             AddExportString('ADDRESS', SCH."Sell-to City" + '-' + SCH."Sell-to Post Code");
//             XMLValues := XMLValues + '</ADDRESS.LIST>';
//         end;

//         if SCH."Ship-to Address" <> '' then begin
//             XMLValues := XMLValues + '<BASICBUYERADDRESS.LIST TYPE="String">';
//             AddExportString('BASICBUYERADDRESS', SCH."Sell-to Address");
//             AddExportString('BASICBUYERADDRESS', SCH."Sell-to Address 2");
//             AddExportString('BASICBUYERADDRESS', SCH."Sell-to City" + '-' + SCH."Sell-to Post Code");
//             XMLValues := XMLValues + '</BASICBUYERADDRESS.LIST>';
//         end;

//         XMLValues := XMLValues + '<BASICORDERTERMS.LIST TYPE="String">';
//         AddExportString('BASICORDERTERMS', SCH."Shipment Method Code");
//         XMLValues := XMLValues + '</BASICORDERTERMS.LIST>';

//         Cust.Get(SCH."Sell-to Customer No.");

//         MasterName := '';
//         if MasterNaming = Masternaming::Code then
//             MasterName := SCH."Sell-to Customer No."
//         else
//             if MasterNaming = Masternaming::Name then
//                 MasterName := Cust.Name
//             else
//                 MasterName := SCH."Sell-to Customer No." + '-' + Cust.Name;

//         MasterName := ConvertMasterName(MasterName);

//         AddExportString('DATE', ConvertTallyDate(SCH."Posting Date"));
//         AddExportString('EFFECTIVEDATE', ConvertTallyDate(SCH."Posting Date"));
//         //AddExportString('BILLOFLADINGDATE',ConvertTallyDate(SCH."LR/RR Date"));
//         AddExportString('STATENAME', GETTallyStateName(SCH."GST Ship-to State Code"));
//         AddExportString('GSTREGISTRATIONTYPE', Format(SCH."GST Customer Type"));
//         AddExportString('NARRATION', Format(SCH."External Document No."));
//         AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(SCH."Sell-to Country/Region Code"));
//         AddExportString('CONSIGNEEGSTIN', SCH."Ship-to GST Reg. No.");
//         AddExportString('PARTYGSTIN', SCH."Ship-to GST Reg. No.");
//         AddExportString('PARTYNAME', MasterName);
//         AddExportString('VOUCHERTYPENAME', 'Credit Note');
//         AddExportString('REFERENCE', SCH."Applies-to Doc. No.");
//         AddExportString('VOUCHERNUMBER', SCH."No.");
//         AddExportString('PARTYLEDGERNAME', MasterName);
//         AddExportString('BASICBASEPARTYNAME', MasterName);
//         AddExportString('PERSISTEDVIEW', 'Invoice Voucher View');
//         //AddExportString('BILLOFLADINGNO',SCH."LR/RR No.");
//         AddExportString('PLACEOFSUPPLY', GETTallyStateName(SCH."GST Ship-to State Code"));
//         //AddExportString('BASICSHIPPEDBY',SCH."Shipping Agent Code");
//         AddExportString('BASICBUYERNAME', MasterName);
//         AddExportString('BASICSHIPDOCUMENTNO', SCH."External Document No.");
//         AddExportString('BASICFINALDESTINATION', SCH."Sell-to City");
//         AddExportString('BASICORDERREF', SCH."External Document No.");
//         //AddExportString('BASICSHIPVESSELNO',SCH."Vehicle No.");
//         AddExportString('BASICDUEDATEOFPYMT', ConvertTallyDate(SCH."Due Date"));
//         AddExportString('BASICDATETIMEOFINVOICE', ConvertTallyDate(SCH."Document Date"));
//         //AddExportString('BASICDATETIMEOFREMOVAL',FORMAT(SCH."Time of Removal"));
//         AddExportString('CONSIGNEESTATENAME', GETTallyStateName(SCH."GST Ship-to State Code"));
//         AddExportString('ENTEREDBY', SCH."User ID");
//         AddExportString('ISINVOICE', 'Yes');
//         /*
//         XMLValues:=XMLValues+'<INVOICEORDERLIST.LIST>';
//         AddExportString('BASICPURCHASEORDERNO',SIH."Order No.");
//         AddExportString('BASICORDERDATE',ConvertTallyDate(SIH."Order Date"));
//         XMLValues:=XMLValues+'</INVOICEORDERLIST.LIST>';
//         */

//         XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//         AddExportString('LEDGERNAME', MasterName);
//         AddExportString('ISDEEMEDPOSITIVE', 'No');
//         AddExportString('ISPARTYLEDGER', 'Yes');
//         AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//         AddExportString('AMOUNT', Format(NettAmount));
//         AddExportValues('<BILLALLOCATIONS.LIST>');
//         AddExportString('NAME', SCH."No.");
//         //AddExportString('BILLCREDITPERIOD',SCH."No.");
//         AddExportString('BILLTYPE', 'New Ref');
//         AddExportString('AMOUNT', Format(NettAmount));
//         AddExportValues('</BILLALLOCATIONS.LIST>');
//         XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';

//         SCL.Reset;
//         SCL.SetRange("Document No.", SCH."No.");
//         SCL.SetFilter("No.", '<>%1', '');
//         if SCL.FindFirst then
//             repeat
//                 SCL.Amount := ROUND(SCL.Amount / CurrencyFactor, 0.01);

//                 if SCL.Type <> SCL.Type::Item then begin
//                     MasterName := '';
//                     VarCode := '';
//                     VarName := '';

//                     if SCL.Type = SCL.Type::"G/L Account" then begin
//                         if GLAcct.Get(SCL."No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                     end;

//                     if SCL.Type = SCL.Type::"Charge (Item)" then begin
//                         if CHItem.Get(SCL."No.") then;
//                         VarCode := CHItem."No.";
//                         VarName := CHItem.Description;
//                     end;

//                     if SCL.Type = SCL.Type::"Fixed Asset" then begin
//                         if FARec.Get(SCL."No.") then;
//                         VarCode := FARec."No.";
//                         VarName := FARec.Description;
//                     end;

//                     if SCL.Type = SCL.Type::Resource then begin
//                         if ResRec.Get(SCL."No.") then;
//                         VarCode := ResRec."No.";
//                         VarName := ResRec.Name;
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);

//                     if RoundAcctNo = SCL."No." then begin
//                         RoundAcctName := MasterName;
//                         RoundAcctAmount := RoundAcctAmount + SCL.Amount;
//                     end else begin
//                         XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//                         AddExportString('LEDGERNAME', MasterName);
//                         AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//                         AddExportString('ISPARTYLEDGER', 'No');
//                         AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//                         AddExportString('AMOUNT', Format(-SCL.Amount));
//                         XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//                     end;
//                 end else begin
//                     Item.Get(SCL."No.");

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Item."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Item.Description
//                         else
//                             MasterName := Item."No." + '-' + Item.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     ItemQty := ' ' + Format(SCL.Quantity) + ' ' + SCL."Unit of Measure Code";

//                     XMLValues := XMLValues + '<ALLINVENTORYENTRIES.LIST>';
//                     AddExportString('STOCKITEMNAME', MasterName);
//                     AddExportString('ISDEEMEDPOSITIVE', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                     AddExportString('RATE', Format(SCL."Unit Price"));
//                     AddExportString('DISCOUNT', Format(SCL."Line Discount %"));
//                     AddExportString('AMOUNT', Format(-SCL.Amount));
//                     AddExportString('ACTUALQTY', ItemQty);
//                     AddExportString('BILLEDQTY', ItemQty);

//                     XMLValues := XMLValues + '<BATCHALLOCATIONS.LIST>';
//                     AddExportString('GODOWNNAME', GETGodownName(SCL."Location Code"));

//                     AddExportString('BATCHNAME', 'Primary Batch');
//                     AddExportString('DESTINATIONGODOWNNAME', GETGodownName(SCL."Location Code"));
//                     //AddExportString('INDENTNO',SIL.Description);
//                     //AddExportString('ORDERNO',SIH."Order No.");
//                     //AddExportString('TRACKINGNUMBER',SIL.Description);
//                     AddExportString('AMOUNT', Format(-SCL.Amount));
//                     AddExportString('ACTUALQTY', ItemQty);
//                     AddExportString('BILLEDQTY', ItemQty);
//                     XMLValues := XMLValues + '</BATCHALLOCATIONS.LIST>';

//                     if GSTGroup.Get(SCL."GST Group Code") then
//                         SalesAcctName := 'Sales @ ' + Format(ROUND(GSTGroup."Tax Rate", 0.1)) + '%'
//                     else
//                         SalesAcctName := 'Sales @ 0%';

//                     XMLValues := XMLValues + '<ACCOUNTINGALLOCATIONS.LIST>';
//                     AddExportString('LEDGERNAME', SalesAcctName);
//                     AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('ISPARTYLEDGER', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('AMOUNT', Format(-SCL.Amount));

//                     /*
//                     XMLValues:=XMLValues+'<CATEGORYALLOCATIONS.LIST>';
//                     AddExportString('CATEGORY',SIL.Description);
//                     AddExportString('ISDEEMEDPOSITIVE','No');
//                     XMLValues:=XMLValues+'<COSTCENTREALLOCATIONS.LIST>';
//                     AddExportString('NAME',SIL.Description);
//                     AddExportString('AMOUNT',SIL.Description);
//                     XMLValues:=XMLValues+'</COSTCENTREALLOCATIONS.LIST>';
//                     XMLValues:=XMLValues+'</CATEGORYALLOCATIONS.LIST>';
//                     */

//                     XMLValues := XMLValues + '</ACCOUNTINGALLOCATIONS.LIST>';
//                     XMLValues := XMLValues + '</ALLINVENTORYENTRIES.LIST>';

//                 end;
//             until SCL.Next = 0;

//         if OtherAmount <> 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'OTHER');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-OtherAmount));
//             AddExportString('VATEXPAMOUNT', Format(-OtherAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if CGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'CGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-CGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(-CGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if SGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'SGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-SGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(-SGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if IGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'IGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-IGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(-IGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if CESSAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'CESS');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-CESSAmount));
//             AddExportString('VATEXPAMOUNT', Format(-CESSAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if RoundAcctAmount <> 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', RoundAcctName);
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-RoundAcctAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         XMLValues := XMLValues + '</VOUCHER>';

//     end;

//     local procedure GenerateXMlDocForTallyPurchaseInvoice(PIH: Record "Purch. Inv. Header")
//     var
//         PIL: Record "Purch. Inv. Line";
//         Vend: Record Vendor;
//         RoundAcctName: Text;
//         RoundAcctAmount: Decimal;
//         JsType: Text;
//         GSTGroup: Record "GST Group";
//     begin
//         XMLValues := XMLValues + '<VOUCHER VCHTYPE="Purchase" ACTION="Create" OBJVIEW="Invoice Voucher View">';

//         CurrencyFactor := GETCurrFactor(PIH."Currency Factor");
//         JsType := '';
//         LineAmount := 0;
//         GSTAmount := 0;
//         GSTBaseAmount := 0;
//         NettAmount := 0;
//         RoundAcctAmount := 0;
//         RoundAcctName := RoundAcctDesc;

//         PIL.Reset;
//         PIL.SetRange("Document No.", PIH."No.");
//         PIL.SetFilter("No.", '<>%1', '');
//         if PIL.FindFirst then
//             repeat
//                 if JsType = '' then
//                     JsType := Format(PIL."GST Jurisdiction Type");

//                 LineAmount := LineAmount + ROUND(PIL.Amount / CurrencyFactor, 0.01);
//                 GSTAmount := GSTAmount + PIL."Total GST Amount";
//                 GSTBaseAmount := GSTBaseAmount + PIL."GST Base Amount";
//                 NettAmount := NettAmount + PIL."Amount To Vendor";
//             until PIL.Next = 0;

//         GSTAmount := ROUND(GSTAmount / CurrencyFactor, 0.01);
//         GSTBaseAmount := ROUND(GSTBaseAmount / CurrencyFactor, 0.01);
//         NettAmount := ROUND(NettAmount / CurrencyFactor, 0.01);


//         IGSTAmount := 0;
//         CGSTAmount := 0;
//         SGSTAmount := 0;
//         CESSAmount := 0;

//         //OtherAmount:=NettAmount-(LineAmount+GSTAmount);

//         if JsType = 'Interstate' then begin
//             IGSTAmount := GSTAmount;
//             CESSAmount := 0;
//         end else begin
//             CGSTAmount := GSTAmount / 2;
//             CGSTAmount := ROUND(CGSTAmount, 0.01);
//             SGSTAmount := CGSTAmount;
//             CESSAmount := 0;
//         end;

//         OtherAmount := NettAmount - (LineAmount + CGSTAmount + SGSTAmount + IGSTAmount + CESSAmount);
//         if (OtherAmount > -1) and (OtherAmount < 1) then begin
//             RoundAcctAmount := RoundAcctAmount + OtherAmount;
//             OtherAmount := 0;
//         end;

//         if PIH."Buy-from Address" <> '' then begin
//             XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//             AddExportString('ADDRESS', PIH."Buy-from Address");
//             AddExportString('ADDRESS', PIH."Buy-from Address 2");
//             AddExportString('ADDRESS', PIH."Buy-from City" + '-' + PIH."Buy-from Post Code");
//             XMLValues := XMLValues + '</ADDRESS.LIST>';
//         end;

//         if PIH."Buy-from Address" <> '' then begin
//             XMLValues := XMLValues + '<BASICBUYERADDRESS.LIST TYPE="String">';
//             AddExportString('BASICBUYERADDRESS', PIH."Buy-from Address");
//             AddExportString('BASICBUYERADDRESS', PIH."Buy-from Address 2");
//             AddExportString('BASICBUYERADDRESS', PIH."Buy-from City" + '-' + PIH."Buy-from Post Code");
//             XMLValues := XMLValues + '</BASICBUYERADDRESS.LIST>';
//         end;

//         XMLValues := XMLValues + '<BASICORDERTERMS.LIST TYPE="String">';
//         AddExportString('BASICORDERTERMS', PIH."Shipment Method Code");
//         XMLValues := XMLValues + '</BASICORDERTERMS.LIST>';

//         Vend.Get(PIH."Buy-from Vendor No.");

//         MasterName := '';
//         if MasterNaming = Masternaming::Code then
//             MasterName := PIH."Buy-from Vendor No."
//         else
//             if MasterNaming = Masternaming::Name then
//                 MasterName := Vend.Name
//             else
//                 MasterName := PIH."Buy-from Vendor No." + '-' + Vend.Name;

//         MasterName := ConvertMasterName(MasterName);

//         AddExportString('DATE', ConvertTallyDate(PIH."Posting Date"));
//         AddExportString('EFFECTIVEDATE', ConvertTallyDate(PIH."Posting Date"));
//         //AddExportString('BILLOFLADINGDATE',ConvertTallyDate(PIH."LR/RR Date"));
//         AddExportString('STATENAME', GETTallyStateName(Vend."State Code"));
//         AddExportString('GSTREGISTRATIONTYPE', Format(Vend."GST Vendor Type"));
//         AddExportString('NARRATION', Format(PIH."Order No."));
//         AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(PIH."Buy-from Country/Region Code"));
//         AddExportString('CONSIGNEEGSTIN', Vend."GST Registration No.");
//         AddExportString('PARTYGSTIN', Vend."GST Registration No.");
//         AddExportString('PARTYNAME', MasterName);
//         AddExportString('VOUCHERTYPENAME', 'Purchase');
//         AddExportString('REFERENCE', PIH."Vendor Invoice No.");
//         AddExportString('REFERENCEDATE', ConvertTallyDate(PIH."Posting Date"));
//         AddExportString('VOUCHERNUMBER', PIH."No.");
//         AddExportString('PARTYLEDGERNAME', MasterName);
//         AddExportString('BASICBASEPARTYNAME', MasterName);
//         AddExportString('PERSISTEDVIEW', 'Invoice Voucher View');
//         //AddExportString('BILLOFLADINGNO',PIH."LR/RR No.");
//         //AddExportString('PLACEOFSUPPLY',GETTallyStateName(SIH."GST Ship-to State Code"));
//         //AddExportString('BASICSHIPPEDBY',PIH."Shipping Agent Code");
//         AddExportString('BASICBUYERNAME', MasterName);
//         AddExportString('BASICSHIPDOCUMENTNO', PIH."Order No.");
//         //AddExportString('BASICFINALDESTINATION',SIH."Sell-to City");
//         AddExportString('BASICORDERREF', PIH."Order No.");
//         //AddExportString('BASICSHIPVESSELNO',PIH."Vehicle No.");
//         AddExportString('BASICDUEDATEOFPYMT', ConvertTallyDate(PIH."Due Date"));
//         AddExportString('BASICDATETIMEOFINVOICE', ConvertTallyDate(PIH."Document Date"));
//         //AddExportString('BASICDATETIMEOFREMOVAL',FORMAT(PIH."Time of Removal"));
//         AddExportString('CONSIGNEESTATENAME', GETTallyStateName(Vend."State Code"));
//         AddExportString('ENTEREDBY', PIH."User ID");
//         AddExportString('ISINVOICE', 'Yes');
//         /*
//         XMLValues:=XMLValues+'<INVOICEORDERLIST.LIST>';
//         AddExportString('BASICPURCHASEORDERNO',SIH."Order No.");
//         AddExportString('BASICORDERDATE',ConvertTallyDate(SIH."Order Date"));
//         XMLValues:=XMLValues+'</INVOICEORDERLIST.LIST>';
//         */

//         XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//         AddExportString('LEDGERNAME', MasterName);
//         AddExportString('ISDEEMEDPOSITIVE', 'No');
//         AddExportString('ISPARTYLEDGER', 'Yes');
//         AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//         AddExportString('AMOUNT', Format(NettAmount));
//         AddExportValues('<BILLALLOCATIONS.LIST>');
//         AddExportString('NAME', PIH."No.");
//         AddExportString('BILLCREDITPERIOD', PIH."No.");
//         AddExportString('BILLTYPE', 'New Ref');
//         AddExportString('AMOUNT', Format(NettAmount));
//         AddExportValues('</BILLALLOCATIONS.LIST>');
//         XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';

//         PIL.Reset;
//         PIL.SetRange("Document No.", PIH."No.");
//         PIL.SetFilter("No.", '<>%1', '');
//         if PIL.FindFirst then
//             repeat
//                 PIL.Amount := ROUND(PIL.Amount / CurrencyFactor, 0.01);

//                 if PIL.Type <> PIL.Type::Item then begin
//                     MasterName := '';
//                     VarCode := '';
//                     VarName := '';

//                     if PIL.Type = PIL.Type::"G/L Account" then begin
//                         if GLAcct.Get(PIL."No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                     end;

//                     if PIL.Type = PIL.Type::"Charge (Item)" then begin
//                         if CHItem.Get(PIL."No.") then;
//                         VarCode := CHItem."No.";
//                         VarName := CHItem.Description;
//                     end;

//                     if PIL.Type = PIL.Type::"Fixed Asset" then begin
//                         if FARec.Get(PIL."No.") then;
//                         VarCode := FARec."No.";
//                         VarName := FARec.Description;
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);

//                     if RoundAcctNo = PIL."No." then begin
//                         RoundAcctName := MasterName;
//                         RoundAcctAmount := RoundAcctAmount + PIL.Amount;
//                     end else begin
//                         XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//                         AddExportString('LEDGERNAME', MasterName);
//                         AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//                         AddExportString('ISPARTYLEDGER', 'No');
//                         AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//                         AddExportString('ISPARTYLEDGER', 'No');
//                         AddExportString('AMOUNT', Format(-PIL.Amount));
//                         XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//                     end;
//                 end else begin
//                     Item.Get(PIL."No.");

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Item."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Item.Description
//                         else
//                             MasterName := Item."No." + '-' + Item.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     ItemQty := ' ' + Format(PIL.Quantity) + ' ' + PIL."Unit of Measure Code";

//                     XMLValues := XMLValues + '<ALLINVENTORYENTRIES.LIST>';
//                     AddExportString('STOCKITEMNAME', MasterName);
//                     AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('RATE', Format(PIL."Unit Cost"));
//                     AddExportString('DISCOUNT', Format(PIL."Line Discount %"));
//                     AddExportString('AMOUNT', Format(-PIL.Amount));
//                     AddExportString('ACTUALQTY', ItemQty);
//                     AddExportString('BILLEDQTY', ItemQty);

//                     XMLValues := XMLValues + '<BATCHALLOCATIONS.LIST>';
//                     AddExportString('GODOWNNAME', GETGodownName(PIL."Location Code"));

//                     AddExportString('BATCHNAME', 'Primary Batch');
//                     AddExportString('DESTINATIONGODOWNNAME', GETGodownName(PIL."Location Code"));
//                     //AddExportString('INDENTNO',SIL.Description);
//                     //AddExportString('ORDERNO',SIH."Order No.");
//                     //AddExportString('TRACKINGNUMBER',SIL.Description);
//                     AddExportString('AMOUNT', Format(-PIL.Amount));
//                     AddExportString('ACTUALQTY', ItemQty);
//                     AddExportString('BILLEDQTY', ItemQty);
//                     XMLValues := XMLValues + '</BATCHALLOCATIONS.LIST>';

//                     if GSTGroup.Get(PIL."GST Group Code") then
//                         SalesAcctName := 'Purchase @ ' + Format(ROUND(GSTGroup."Tax Rate", 0.1)) + '%'
//                     else
//                         SalesAcctName := 'Purchase @ 0%';
//                     //SalesAcctName:='Purchase @ '+FORMAT(ROUND(PIL."GST %",0.1))+'%';
//                     XMLValues := XMLValues + '<ACCOUNTINGALLOCATIONS.LIST>';
//                     AddExportString('LEDGERNAME', SalesAcctName);
//                     AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('ISPARTYLEDGER', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('AMOUNT', Format(-PIL.Amount));

//                     /*
//                     XMLValues:=XMLValues+'<CATEGORYALLOCATIONS.LIST>';
//                     AddExportString('CATEGORY',SIL.Description);
//                     AddExportString('ISDEEMEDPOSITIVE','No');
//                     XMLValues:=XMLValues+'<COSTCENTREALLOCATIONS.LIST>';
//                     AddExportString('NAME',SIL.Description);
//                     AddExportString('AMOUNT',SIL.Description);
//                     XMLValues:=XMLValues+'</COSTCENTREALLOCATIONS.LIST>';
//                     XMLValues:=XMLValues+'</CATEGORYALLOCATIONS.LIST>';
//                     */

//                     XMLValues := XMLValues + '</ACCOUNTINGALLOCATIONS.LIST>';
//                     XMLValues := XMLValues + '</ALLINVENTORYENTRIES.LIST>';

//                 end;
//             until PIL.Next = 0;

//         if OtherAmount <> 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'OTHER');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-OtherAmount));
//             AddExportString('VATEXPAMOUNT', Format(-OtherAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if CGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'CGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-CGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(-CGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if SGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'SGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-SGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(-SGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if IGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'IGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-IGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(-IGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if CESSAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'CESS');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-CESSAmount));
//             AddExportString('VATEXPAMOUNT', Format(-CESSAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if CESSAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'CESS');
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('AMOUNT', Format(-CESSAmount));
//             AddExportString('VATEXPAMOUNT', Format(-CESSAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if RoundAcctAmount <> 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', RoundAcctName);
//             AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('AMOUNT', Format(-RoundAcctAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         XMLValues := XMLValues + '</VOUCHER>';

//     end;

//     local procedure GenerateXMlDocForTallyPurchaseCrMemo(PCH: Record "Purch. Cr. Memo Hdr.")
//     var
//         PCL: Record "Purch. Cr. Memo Line";
//         Vend: Record Vendor;
//         RoundAcctName: Text;
//         RoundAcctAmount: Decimal;
//         JsType: Text;
//         GSTGroup: Record "GST Group";
//     begin
//         XMLValues := XMLValues + '<VOUCHER VCHTYPE="Debit Note" ACTION="Create" OBJVIEW="Invoice Voucher View">';

//         CurrencyFactor := GETCurrFactor(PCH."Currency Factor");
//         JsType := '';
//         LineAmount := 0;
//         GSTAmount := 0;
//         GSTBaseAmount := 0;
//         NettAmount := 0;

//         PCL.Reset;
//         PCL.SetRange("Document No.", PCH."No.");
//         PCL.SetFilter("No.", '<>%1', '');
//         if PCL.FindFirst then
//             repeat
//                 if JsType = '' then
//                     JsType := Format(PCL."GST Jurisdiction Type");

//                 LineAmount := LineAmount + ROUND(PCL.Amount / CurrencyFactor, 0.01);
//                 GSTAmount := GSTAmount + PCL."Total GST Amount";
//                 GSTBaseAmount := GSTBaseAmount + PCL."GST Base Amount";
//                 NettAmount := NettAmount + PCL."Amount To Vendor";
//             until PCL.Next = 0;

//         GSTAmount := ROUND(GSTAmount / CurrencyFactor, 0.01);
//         GSTBaseAmount := ROUND(GSTBaseAmount / CurrencyFactor, 0.01);
//         NettAmount := ROUND(NettAmount / CurrencyFactor, 0.01);


//         IGSTAmount := 0;
//         CGSTAmount := 0;
//         SGSTAmount := 0;
//         CESSAmount := 0;
//         RoundAcctName := '';
//         RoundAcctAmount := 0;
//         //OtherAmount:=NettAmount-(LineAmount+GSTAmount);

//         if JsType = 'Interstate' then begin
//             IGSTAmount := GSTAmount;
//             CESSAmount := 0;
//         end else begin
//             CGSTAmount := GSTAmount / 2;
//             CGSTAmount := ROUND(CGSTAmount, 0.01);
//             SGSTAmount := CGSTAmount;
//             CESSAmount := 0;
//         end;

//         OtherAmount := NettAmount - (LineAmount + CGSTAmount + SGSTAmount + IGSTAmount + CESSAmount);


//         if PCH."Buy-from Address" <> '' then begin
//             XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//             AddExportString('ADDRESS', PCH."Buy-from Address");
//             AddExportString('ADDRESS', PCH."Buy-from Address 2");
//             AddExportString('ADDRESS', PCH."Buy-from City" + '-' + PCH."Buy-from Post Code");
//             XMLValues := XMLValues + '</ADDRESS.LIST>';
//         end;

//         if PCH."Buy-from Address" <> '' then begin
//             XMLValues := XMLValues + '<BASICBUYERADDRESS.LIST TYPE="String">';
//             AddExportString('BASICBUYERADDRESS', PCH."Buy-from Address");
//             AddExportString('BASICBUYERADDRESS', PCH."Buy-from Address 2");
//             AddExportString('BASICBUYERADDRESS', PCH."Buy-from City" + '-' + PCH."Buy-from Post Code");
//             XMLValues := XMLValues + '</BASICBUYERADDRESS.LIST>';
//         end;

//         XMLValues := XMLValues + '<BASICORDERTERMS.LIST TYPE="String">';
//         AddExportString('BASICORDERTERMS', PCH."Shipment Method Code");
//         XMLValues := XMLValues + '</BASICORDERTERMS.LIST>';

//         Vend.Get(PCH."Buy-from Vendor No.");

//         MasterName := '';
//         if MasterNaming = Masternaming::Code then
//             MasterName := PCH."Buy-from Vendor No."
//         else
//             if MasterNaming = Masternaming::Name then
//                 MasterName := Vend.Name
//             else
//                 MasterName := PCH."Buy-from Vendor No." + '-' + Vend.Name;

//         MasterName := ConvertMasterName(MasterName);

//         AddExportString('DATE', ConvertTallyDate(PCH."Posting Date"));
//         AddExportString('EFFECTIVEDATE', ConvertTallyDate(PCH."Posting Date"));
//         //AddExportString('BILLOFLADINGDATE',ConvertTallyDate(PIH."LR/RR Date"));
//         AddExportString('STATENAME', GETTallyStateName(Vend."State Code"));
//         AddExportString('GSTREGISTRATIONTYPE', Format(Vend."GST Vendor Type"));
//         AddExportString('NARRATION', Format(PCH."Pre-Assigned No."));
//         AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(PCH."Buy-from Country/Region Code"));
//         AddExportString('CONSIGNEEGSTIN', Vend."GST Registration No.");
//         AddExportString('PARTYGSTIN', Vend."GST Registration No.");
//         AddExportString('PARTYNAME', MasterName);
//         AddExportString('VOUCHERTYPENAME', 'Debit Note');
//         AddExportString('REFERENCE', PCH."Applies-to Doc. No.");
//         AddExportString('REFERENCEDATE', ConvertTallyDate(PCH."Posting Date"));
//         AddExportString('VOUCHERNUMBER', PCH."No.");
//         AddExportString('PARTYLEDGERNAME', MasterName);
//         AddExportString('BASICBASEPARTYNAME', MasterName);
//         AddExportString('PERSISTEDVIEW', 'Invoice Voucher View');
//         //AddExportString('BILLOFLADINGNO',PIH."LR/RR No.");
//         //AddExportString('PLACEOFSUPPLY',GETTallyStateName(SIH."GST Ship-to State Code"));
//         //AddExportString('BASICSHIPPEDBY',PIH."Shipping Agent Code");
//         AddExportString('BASICBUYERNAME', MasterName);
//         AddExportString('BASICSHIPDOCUMENTNO', PCH."Pre-Assigned No.");
//         //AddExportString('BASICFINALDESTINATION',SIH."Sell-to City");
//         AddExportString('BASICORDERREF', PCH."Pre-Assigned No.");
//         //AddExportString('BASICSHIPVESSELNO',PCH."Vehicle No.");
//         AddExportString('BASICDUEDATEOFPYMT', ConvertTallyDate(PCH."Due Date"));
//         AddExportString('BASICDATETIMEOFINVOICE', ConvertTallyDate(PCH."Document Date"));
//         //AddExportString('BASICDATETIMEOFREMOVAL',FORMAT(PIH."Time of Removal"));
//         AddExportString('CONSIGNEESTATENAME', GETTallyStateName(Vend."State Code"));
//         AddExportString('ENTEREDBY', PCH."User ID");
//         AddExportString('ISINVOICE', 'Yes');
//         /*
//         XMLValues:=XMLValues+'<INVOICEORDERLIST.LIST>';
//         AddExportString('BASICPURCHASEORDERNO',SIH."Order No.");
//         AddExportString('BASICORDERDATE',ConvertTallyDate(SIH."Order Date"));
//         XMLValues:=XMLValues+'</INVOICEORDERLIST.LIST>';
//         */

//         XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//         AddExportString('LEDGERNAME', MasterName);
//         AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//         AddExportString('ISPARTYLEDGER', 'Yes');
//         AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//         AddExportString('AMOUNT', Format(-NettAmount));
//         AddExportValues('<BILLALLOCATIONS.LIST>');
//         AddExportString('NAME', PCH."No.");
//         AddExportString('BILLCREDITPERIOD', PCH."No.");
//         AddExportString('BILLTYPE', 'New Ref');
//         AddExportString('AMOUNT', Format(-NettAmount));
//         AddExportValues('</BILLALLOCATIONS.LIST>');
//         XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';

//         PCL.Reset;
//         PCL.SetRange("Document No.", PCH."No.");
//         PCL.SetFilter("No.", '<>%1', '');
//         if PCL.FindFirst then
//             repeat
//                 PCL.Amount := ROUND(PCL.Amount / CurrencyFactor, 0.01);

//                 if PCL.Type <> PCL.Type::Item then begin
//                     MasterName := '';
//                     VarCode := '';
//                     VarName := '';

//                     if PCL.Type = PCL.Type::"G/L Account" then begin
//                         if GLAcct.Get(PCL."No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                     end;

//                     if PCL.Type = PCL.Type::"Charge (Item)" then begin
//                         if CHItem.Get(PCL."No.") then;
//                         VarCode := CHItem."No.";
//                         VarName := CHItem.Description;
//                     end;

//                     if PCL.Type = PCL.Type::"Fixed Asset" then begin
//                         if FARec.Get(PCL."No.") then;
//                         VarCode := FARec."No.";
//                         VarName := FARec.Description;
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);


//                     if RoundAcctNo = PCL."No." then begin
//                         RoundAcctName := MasterName;
//                         RoundAcctAmount := RoundAcctAmount + PCL.Amount;
//                     end else begin
//                         XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//                         AddExportString('LEDGERNAME', MasterName);
//                         AddExportString('ISDEEMEDPOSITIVE', 'No');
//                         AddExportString('ISPARTYLEDGER', 'No');
//                         AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                         AddExportString('ISPARTYLEDGER', 'No');
//                         AddExportString('AMOUNT', Format(PCL.Amount));
//                         XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//                     end;
//                 end else begin
//                     Item.Get(PCL."No.");

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Item."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Item.Description
//                         else
//                             MasterName := Item."No." + '-' + Item.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     ItemQty := ' ' + Format(PCL.Quantity) + ' ' + PCL."Unit of Measure Code";

//                     XMLValues := XMLValues + '<ALLINVENTORYENTRIES.LIST>';
//                     AddExportString('STOCKITEMNAME', MasterName);
//                     AddExportString('ISDEEMEDPOSITIVE', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                     AddExportString('RATE', Format(PCL."Unit Cost"));
//                     AddExportString('DISCOUNT', Format(PCL."Line Discount %"));
//                     AddExportString('AMOUNT', Format(PCL.Amount));
//                     AddExportString('ACTUALQTY', ItemQty);
//                     AddExportString('BILLEDQTY', ItemQty);

//                     XMLValues := XMLValues + '<BATCHALLOCATIONS.LIST>';
//                     AddExportString('GODOWNNAME', GETGodownName(PCL."Location Code"));

//                     AddExportString('BATCHNAME', 'Primary Batch');
//                     AddExportString('DESTINATIONGODOWNNAME', GETGodownName(PCL."Location Code"));
//                     //AddExportString('INDENTNO',SIL.Description);
//                     //AddExportString('ORDERNO',SIH."Order No.");
//                     //AddExportString('TRACKINGNUMBER',SIL.Description);
//                     AddExportString('AMOUNT', Format(PCL.Amount));
//                     AddExportString('ACTUALQTY', ItemQty);
//                     AddExportString('BILLEDQTY', ItemQty);
//                     XMLValues := XMLValues + '</BATCHALLOCATIONS.LIST>';

//                     if GSTGroup.Get(PCL."GST Group Code") then
//                         SalesAcctName := 'Purchase @ ' + Format(ROUND(GSTGroup."Tax Rate", 0.1)) + '%'
//                     else
//                         SalesAcctName := 'Purchase @ 0%';
//                     //SalesAcctName:='Purchase @ '+FORMAT(ROUND(PCL."GST %",0.1))+'%';
//                     XMLValues := XMLValues + '<ACCOUNTINGALLOCATIONS.LIST>';
//                     AddExportString('LEDGERNAME', SalesAcctName);
//                     AddExportString('ISDEEMEDPOSITIVE', 'No');
//                     AddExportString('ISPARTYLEDGER', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                     AddExportString('AMOUNT', Format(PCL.Amount));

//                     /*
//                     XMLValues:=XMLValues+'<CATEGORYALLOCATIONS.LIST>';
//                     AddExportString('CATEGORY',SIL.Description);
//                     AddExportString('ISDEEMEDPOSITIVE','No');
//                     XMLValues:=XMLValues+'<COSTCENTREALLOCATIONS.LIST>';
//                     AddExportString('NAME',SIL.Description);
//                     AddExportString('AMOUNT',SIL.Description);
//                     XMLValues:=XMLValues+'</COSTCENTREALLOCATIONS.LIST>';
//                     XMLValues:=XMLValues+'</CATEGORYALLOCATIONS.LIST>';
//                     */

//                     XMLValues := XMLValues + '</ACCOUNTINGALLOCATIONS.LIST>';
//                     XMLValues := XMLValues + '</ALLINVENTORYENTRIES.LIST>';

//                 end;
//             until PCL.Next = 0;

//         if OtherAmount <> 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'OTHER');
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(OtherAmount));
//             AddExportString('VATEXPAMOUNT', Format(OtherAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if CGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'CGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(CGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(CGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if SGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'SGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(SGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(SGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if IGSTAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'IGST');
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(IGSTAmount));
//             AddExportString('VATEXPAMOUNT', Format(IGSTAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if CESSAmount > 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', 'CESS');
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(CESSAmount));
//             AddExportString('VATEXPAMOUNT', Format(CESSAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         if RoundAcctAmount <> 0 then begin
//             XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//             AddExportString('LEDGERNAME', RoundAcctName);
//             AddExportString('ISDEEMEDPOSITIVE', 'No');
//             AddExportString('ISPARTYLEDGER', 'No');
//             AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//             AddExportString('AMOUNT', Format(RoundAcctAmount));
//             XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//         end;

//         XMLValues := XMLValues + '</VOUCHER>';

//     end;

//     local procedure GenerateXMlDocForTallyPayment(InLocCode: Text; InSourceCode: Text; InPostingDate: Date; InDoctNo: Text; InDocType: Text; InTxnType: Text)
//     var
//         GLEntry: Record "G/L Entry";
//         DocLineNo: Integer;
//         BankAcct: Record "Bank Account";
//         CustAcct: Record Customer;
//         VendAcct: Record Vendor;
//         FAAcct: Record "Fixed Asset";
//         IsPartyLedger: Text;
//         VLE: Record "Vendor Ledger Entry";
//         VLE2: Record "Vendor Ledger Entry";
//         DVLE: Record "Detailed Vendor Ledg. Entry";
//         ISDebitEntry: Text;
//     begin
//         DocLineNo := 0;
//         GLEntry.Reset;
//         GLEntry.SetCurrentkey(Amount);
//         GLEntry.SetAscending(Amount, false);
//         //GLEntry.SETFILTER("Location Code",InLocCode);
//         GLEntry.SetFilter("Source Code", InSourceCode);
//         GLEntry.SetRange("Posting Date", InPostingDate);
//         GLEntry.SetFilter("Document No.", InDoctNo);
//         if GLEntry.FindFirst then
//             repeat
//                 GLEntry.CalcFields("G/L Account Name");
//                 DocLineNo := DocLineNo + 1;

//                 MasterName := '';
//                 VarCode := GLEntry."G/L Account No.";
//                 VarName := GLEntry."G/L Account Name";
//                 //MasterName:=VarCode+'-'+VarName;
//                 IsPartyLedger := 'No';
//                 ISDebitEntry := 'No';

//                 GLAcct.Get(GLEntry."G/L Account No.");

//                 if (GLAcct."Control Accounts") and (GLEntry."Source No." <> '') then begin

//                     if GLEntry."Source Type" = GLEntry."source type"::" " then begin
//                         VarCode := VarCode;
//                         VarName := VarName;
//                     end else
//                         if GLEntry."Source Type" = GLEntry."source type"::"Bank Account" then begin
//                             if BankAcct.Get(GLEntry."Source No.") then;
//                             VarCode := BankAcct."No.";
//                             VarName := BankAcct.Name;
//                         end else
//                             if GLEntry."Source Type" = GLEntry."source type"::Customer then begin
//                                 if CustAcct.Get(GLEntry."Source No.") then;
//                                 VarCode := CustAcct."No.";
//                                 VarName := CustAcct.Name;
//                                 IsPartyLedger := 'Yes';
//                             end else
//                                 if GLEntry."Source Type" = GLEntry."source type"::Vendor then begin
//                                     if VendAcct.Get(GLEntry."Source No.") then;
//                                     VarCode := VendAcct."No.";
//                                     VarName := VendAcct.Name;
//                                     IsPartyLedger := 'Yes';
//                                 end else
//                                     if GLEntry."Source Type" = GLEntry."source type"::"Fixed Asset" then begin
//                                         if FAAcct.Get(GLEntry."Source No.") then;
//                                         VarCode := FAAcct."No.";
//                                         VarName := FAAcct.Description;
//                                     end;

//                 end;
//                 /*
//                 IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::"G/L Account" THEN BEGIN
//                   IF GLAcct.GET(GLEntry."Bal. Account No.") THEN ;
//                   VarCode:=GLAcct."No.";
//                   VarName:=GLAcct.Name;
//                 END ELSE IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::"Bank Account" THEN BEGIN
//                   IF BankAcct.GET(GLEntry."Bal. Account No.") THEN ;
//                   VarCode:=BankAcct."No.";
//                   VarName:=BankAcct.Name;
//                 END ELSE IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::Customer THEN BEGIN
//                   IF CustAcct.GET(GLEntry."Bal. Account No.") THEN ;
//                   VarCode:=CustAcct."No.";
//                   VarName:=CustAcct.Name;
//                   IsPartyLedger:='Yes';
//                 END ELSE IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::Vendor THEN BEGIN
//                   IF VendAcct.GET(GLEntry."Bal. Account No.") THEN ;
//                   VarCode:=VendAcct."No.";
//                   VarName:=VendAcct.Name;
//                   IsPartyLedger:='Yes';
//                 END ELSE IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::"Fixed Asset" THEN BEGIN
//                   IF FAAcct.GET(GLEntry."Bal. Account No.") THEN ;
//                   VarCode:=FAAcct."No.";
//                   VarName:=FAAcct.Description;
//                 END;
//                 */



//                 if MasterNaming = Masternaming::Code then
//                     MasterName := VarCode
//                 else
//                     if MasterNaming = Masternaming::Name then
//                         MasterName := VarName
//                     else
//                         MasterName := VarCode + '-' + VarName;

//                 MasterName := ConvertMasterName(MasterName);

//                 if DocLineNo = 1 then begin
//                     XMLValues := XMLValues + '<VOUCHER VCHTYPE="' + InTxnType + '" ACTION="Create" OBJVIEW="Accounting Voucher View">';
//                     AddExportString('DATE', ConvertTallyDate(GLEntry."Posting Date"));
//                     AddExportString('EFFECTIVEDATE', ConvertTallyDate(GLEntry."Posting Date"));
//                     AddExportString('VOUCHERNUMBER', GLEntry."Document No.");
//                     AddExportString('REFERENCE', GLEntry."External Document No.");
//                     AddExportString('NARRATION', GLEntry."Document No.");
//                     AddExportString('PERSISTEDVIEW', 'Accounting Voucher View');
//                     AddExportString('PARTYLEDGERNAME', MasterName);
//                     AddExportString('VOUCHERTYPENAME', InDocType);
//                 end;

//                 XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//                 AddExportString('LEDGERNAME', MasterName);
//                 AddExportString('ISPARTYLEDGER', IsPartyLedger);
//                 if GLEntry.Amount > 0 then begin
//                     AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('AMOUNT', Format(-GLEntry.Amount));
//                     if GLEntry."Source Type" = GLEntry."source type"::Vendor then begin
//                         DVLE.Reset;
//                         DVLE.SetRange("Applied Vend. Ledger Entry No.", GLEntry."Entry No.");
//                         DVLE.SetFilter("Vendor Ledger Entry No.", '<>%1', GLEntry."Entry No.");
//                         if DVLE.FindFirst then
//                             repeat
//                                 if VLE.Get(DVLE."Vendor Ledger Entry No.") then begin
//                                     XMLValues := XMLValues + '<BILLALLOCATIONS.LIST>';
//                                     AddExportString('BILLTYPE', 'Agst Ref');
//                                     AddExportString('NAME', VLE."Document No.");
//                                     AddExportString('AMOUNT', Format(-DVLE."Amount (LCY)"));
//                                     XMLValues := XMLValues + '</BILLALLOCATIONS.LIST>';
//                                 end;
//                             until DVLE.Next = 0;

//                         /*
//                        // MESSAGE(FORMAT(GLEntry."Entry No.")+'-'+FORMAT(GLEntry.Amount));//MUKESH
//                         VLE.RESET;
//                         VLE.SETRANGE("Vendor No.",GLEntry."Source No.");
//                         VLE.SETRANGE("Document No.",GLEntry."Document No.");
//                         IF VLE.FINDFIRST THEN BEGIN
//                           DVLE.RESET;
//                           DVLE.SETRANGE("Vendor Ledger Entry No.",VLE."Entry No.");
//                           DVLE.SETFILTER("Applied Vend. Ledger Entry No.",'<>%1',0);
//                           DVLE.SETRANGE("Document Type",DVLE."Document Type"::Invoice);
//                           MESSAGE(FORMAT(VLE."Entry No."));

//                           IF DVLE.FINDFIRST THEN REPEAT
//                               IF VLE2.GET(DVLE."Applied Vend. Ledger Entry No.") THEN BEGIN
//                                 VLE2.CALCFIELDS(VLE2."Amount (LCY)");
//                                 //MUKESH
//                                 XMLValues:=XMLValues+'<BILLALLOCATIONS.LIST>';
//                                 AddExportString('BILLTYPE','Agst Ref');
//                                 AddExportString('NAME',VLE2."Document No.");
//                                 AddExportString('AMOUNT',FORMAT(VLE2."Amount (LCY)"));
//                                 XMLValues:=XMLValues+'</BILLALLOCATIONS.LIST>';
//                               END;
//                           UNTIL DVLE.NEXT=0;
//                         END;
//                         */
//                     end;

//                 end else begin
//                     AddExportString('ISDEEMEDPOSITIVE', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                     AddExportString('AMOUNT', Format(-GLEntry.Amount));
//                 end;
//                 XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//             until GLEntry.Next = 0;

//         XMLValues := XMLValues + '</VOUCHER>';

//     end;

//     local procedure GenerateXMlDocForTallyReceipt(InLocCode: Text; InSourceCode: Text; InPostingDate: Date; InDoctNo: Text; InDocType: Text; InTxnType: Text)
//     var
//         GLEntry: Record "G/L Entry";
//         DocLineNo: Integer;
//         BankAcct: Record "Bank Account";
//         CustAcct: Record Customer;
//         VendAcct: Record Vendor;
//         FAAcct: Record "Fixed Asset";
//         IsPartyLedger: Text;
//         CLE: Record "Cust. Ledger Entry";
//         CLE2: Record "Cust. Ledger Entry";
//         DCLE: Record "Detailed Cust. Ledg. Entry";
//     begin
//         DocLineNo := 0;
//         GLEntry.Reset;
//         GLEntry.SetCurrentkey(Amount);
//         //GLEntry.SETASCENDING(Amount,FALSE);
//         //GLEntry.SETFILTER("Location Code",InLocCode);
//         GLEntry.SetFilter("Source Code", InSourceCode);
//         GLEntry.SetRange("Posting Date", InPostingDate);
//         GLEntry.SetFilter("Document No.", InDoctNo);
//         GLEntry.SetFilter("G/L Account No.", '<>%1', '');
//         if GLEntry.FindFirst then
//             repeat
//                 GLEntry.CalcFields("G/L Account Name");
//                 DocLineNo := DocLineNo + 1;

//                 MasterName := '';
//                 VarCode := GLEntry."G/L Account No.";
//                 VarName := GLEntry."G/L Account Name";
//                 //MasterName:=VarCode+'-'+VarName;
//                 IsPartyLedger := 'No';

//                 if not GLAcct.Get(GLEntry."G/L Account No.") then
//                     Error(Format(GLEntry."Entry No.") + '-' + Format(GLEntry."Posting Date"));

//                 if (GLAcct."Control Accounts") and (GLEntry."Source No." <> '') then begin

//                     if GLEntry."Source Type" = GLEntry."source type"::" " then begin
//                         VarCode := VarCode;
//                         VarName := VarName;
//                     end else
//                         if GLEntry."Source Type" = GLEntry."source type"::"Bank Account" then begin
//                             if BankAcct.Get(GLEntry."Source No.") then;
//                             VarCode := BankAcct."No.";
//                             VarName := BankAcct.Name;
//                         end else
//                             if GLEntry."Source Type" = GLEntry."source type"::Customer then begin
//                                 if CustAcct.Get(GLEntry."Source No.") then;
//                                 VarCode := CustAcct."No.";
//                                 VarName := CustAcct.Name;
//                                 IsPartyLedger := 'Yes';
//                             end else
//                                 if GLEntry."Source Type" = GLEntry."source type"::Vendor then begin
//                                     if VendAcct.Get(GLEntry."Source No.") then;
//                                     VarCode := VendAcct."No.";
//                                     VarName := VendAcct.Name;
//                                     IsPartyLedger := 'Yes';
//                                 end else
//                                     if GLEntry."Source Type" = GLEntry."source type"::"Fixed Asset" then begin
//                                         if FAAcct.Get(GLEntry."Source No.") then;
//                                         VarCode := FAAcct."No.";
//                                         VarName := FAAcct.Description;
//                                     end;

//                 end;

//                 /*
//                 IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::"G/L Account" THEN BEGIN
//                   IF GLAcct.GET(GLEntry."Bal. Account No.") THEN ;
//                   VarCode:=GLAcct."No.";
//                   VarName:=GLAcct.Name;
//                 END ELSE IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::"Bank Account" THEN BEGIN
//                   IF BankAcct.GET(GLEntry."Bal. Account No.") THEN ;
//                   VarCode:=BankAcct."No.";
//                   VarName:=BankAcct.Name;
//                 END ELSE IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::Customer THEN BEGIN
//                   IF CustAcct.GET(GLEntry."Bal. Account No.") THEN ;
//                   VarCode:=CustAcct."No.";
//                   VarName:=CustAcct.Name;
//                   IsPartyLedger:='Yes';
//                 END ELSE IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::Vendor THEN BEGIN
//                   IF VendAcct.GET(GLEntry."Bal. Account No.") THEN ;
//                   VarCode:=VendAcct."No.";
//                   VarName:=VendAcct.Name;
//                   IsPartyLedger:='Yes';
//                 END ELSE IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::"Fixed Asset" THEN BEGIN
//                   IF FAAcct.GET(GLEntry."Bal. Account No.") THEN ;
//                   VarCode:=FAAcct."No.";
//                   VarName:=FAAcct.Description;
//                 END;
//                 */


//                 if MasterNaming = Masternaming::Code then
//                     MasterName := VarCode
//                 else
//                     if MasterNaming = Masternaming::Name then
//                         MasterName := VarName
//                     else
//                         MasterName := VarCode + '-' + VarName;

//                 MasterName := ConvertMasterName(MasterName);

//                 if DocLineNo = 1 then begin
//                     XMLValues := XMLValues + '<VOUCHER VCHTYPE="' + InTxnType + '" ACTION="Create" OBJVIEW="Accounting Voucher View">';
//                     AddExportString('DATE', ConvertTallyDate(GLEntry."Posting Date"));
//                     AddExportString('EFFECTIVEDATE', ConvertTallyDate(GLEntry."Posting Date"));
//                     AddExportString('VOUCHERNUMBER', GLEntry."Document No.");
//                     AddExportString('REFERENCE', GLEntry."External Document No.");
//                     AddExportString('NARRATION', GLEntry."Document No.");
//                     AddExportString('PERSISTEDVIEW', 'Accounting Voucher View');
//                     AddExportString('PARTYLEDGERNAME', MasterName);
//                     AddExportString('VOUCHERTYPENAME', InDocType);
//                 end;

//                 XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//                 AddExportString('LEDGERNAME', MasterName);
//                 AddExportString('ISPARTYLEDGER', IsPartyLedger);
//                 if GLEntry.Amount > 0 then begin
//                     AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('AMOUNT', Format(-GLEntry.Amount));
//                 end else begin
//                     AddExportString('ISDEEMEDPOSITIVE', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                     AddExportString('AMOUNT', Format(-GLEntry.Amount));
//                     if GLEntry."Source Type" = GLEntry."source type"::Customer then begin
//                         //MESSAGE(FORMAT(GLEntry."Entry No."));
//                         DCLE.Reset;
//                         DCLE.SetRange("Applied Cust. Ledger Entry No.", GLEntry."Entry No.");
//                         DCLE.SetFilter("Cust. Ledger Entry No.", '<>%1', GLEntry."Entry No.");
//                         if DCLE.FindFirst then
//                             repeat
//                                 if CLE.Get(DCLE."Cust. Ledger Entry No.") then begin
//                                     XMLValues := XMLValues + '<BILLALLOCATIONS.LIST>';
//                                     AddExportString('BILLTYPE', 'Agst Ref');
//                                     AddExportString('NAME', CLE."Document No.");
//                                     AddExportString('AMOUNT', Format(-DCLE."Amount (LCY)"));
//                                     XMLValues := XMLValues + '</BILLALLOCATIONS.LIST>';
//                                 end;
//                             until DCLE.Next = 0;

//                         /*
//                         CLE.RESET;
//                         CLE.SETRANGE("Customer No.",GLEntry."Source No.");
//                         CLE.SETRANGE("Document No.",GLEntry."Document No.");
//                         IF CLE.FINDFIRST THEN BEGIN
//                           DCLE.RESET;
//                           DCLE.SETRANGE("Cust. Ledger Entry No.",CLE."Entry No.");
//                           DCLE.SETFILTER("Applied Cust. Ledger Entry No.",'<>%1',0);
//                           DCLE.SETRANGE("Document Type",DCLE."Document Type"::Invoice);
//                           IF DCLE.FINDFIRST THEN REPEAT
//                               IF CLE2.GET(DCLE."Applied Cust. Ledger Entry No.") THEN BEGIN
//                                 CLE2.CALCFIELDS(CLE2."Amount (LCY)");
//                                 //MUKESH
//                                 XMLValues:=XMLValues+'<BILLALLOCATIONS.LIST>';
//                                 AddExportString('BILLTYPE','Agst Ref');
//                                 AddExportString('NAME',CLE2."Document No.");
//                                 AddExportString('AMOUNT',FORMAT(CLE2."Amount (LCY)"));
//                                 XMLValues:=XMLValues+'</BILLALLOCATIONS.LIST>';
//                               END;
//                           UNTIL DCLE.NEXT=0;
//                         END;
//                         */

//                     end;

//                 end;
//                 XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//             until GLEntry.Next = 0;

//         XMLValues := XMLValues + '</VOUCHER>';

//     end;

//     local procedure GenerateXMlDocForTallyJournal(InLocCode: Text; InSourceCode: Text; InPostingDate: Date; InDoctNo: Text; InDocType: Text; InTxnType: Text)
//     var
//         GLEntry: Record "G/L Entry";
//         DocLineNo: Integer;
//         BankAcct: Record "Bank Account";
//         CustAcct: Record Customer;
//         VendAcct: Record Vendor;
//         FAAcct: Record "Fixed Asset";
//         IsPartyLedger: Text;
//     begin
//         DocLineNo := 0;
//         GLEntry.Reset;
//         GLEntry.SetCurrentkey(Amount);
//         GLEntry.SetAscending(Amount, false);
//         //GLEntry.SETFILTER("Location Code",InLocCode);
//         GLEntry.SetFilter("Source Code", InSourceCode);
//         GLEntry.SetRange("Posting Date", InPostingDate);
//         GLEntry.SetFilter("Document No.", InDoctNo);
//         if GLEntry.FindFirst then
//             repeat
//                 GLEntry.CalcFields("G/L Account Name");
//                 DocLineNo := DocLineNo + 1;

//                 MasterName := '';
//                 VarCode := GLEntry."G/L Account No.";
//                 VarName := GLEntry."G/L Account Name";
//                 //MasterName:=VarCode+'-'+VarName;
//                 IsPartyLedger := 'No';
//                 GLAcct.Get(GLEntry."G/L Account No.");

//                 if (GLAcct."Control Accounts") and (GLEntry."Source No." <> '') then begin

//                     if GLEntry."Source Type" = GLEntry."source type"::" " then begin
//                         VarCode := VarCode;
//                         VarName := VarName;
//                     end else
//                         if GLEntry."Source Type" = GLEntry."source type"::"Bank Account" then begin
//                             if BankAcct.Get(GLEntry."Source No.") then;
//                             VarCode := BankAcct."No.";
//                             VarName := BankAcct.Name;
//                         end else
//                             if GLEntry."Source Type" = GLEntry."source type"::Customer then begin
//                                 if CustAcct.Get(GLEntry."Source No.") then;
//                                 VarCode := CustAcct."No.";
//                                 VarName := CustAcct.Name;
//                                 IsPartyLedger := 'Yes';
//                             end else
//                                 if GLEntry."Source Type" = GLEntry."source type"::Vendor then begin
//                                     if VendAcct.Get(GLEntry."Source No.") then;
//                                     VarCode := VendAcct."No.";
//                                     VarName := VendAcct.Name;
//                                     IsPartyLedger := 'Yes';
//                                 end else
//                                     if GLEntry."Source Type" = GLEntry."source type"::"Fixed Asset" then begin
//                                         if FAAcct.Get(GLEntry."Source No.") then;
//                                         VarCode := FAAcct."No.";
//                                         VarName := FAAcct.Description;
//                                     end;

//                 end;

//                 if MasterNaming = Masternaming::Code then
//                     MasterName := VarCode
//                 else
//                     if MasterNaming = Masternaming::Name then
//                         MasterName := VarName
//                     else
//                         MasterName := VarCode + '-' + VarName;

//                 MasterName := ConvertMasterName(MasterName);

//                 if DocLineNo = 1 then begin
//                     XMLValues := XMLValues + '<VOUCHER VCHTYPE="' + InTxnType + '" ACTION="Create" OBJVIEW="Accounting Voucher View">';
//                     AddExportString('DATE', ConvertTallyDate(GLEntry."Posting Date"));
//                     AddExportString('EFFECTIVEDATE', ConvertTallyDate(GLEntry."Posting Date"));
//                     AddExportString('VOUCHERNUMBER', GLEntry."Document No.");
//                     AddExportString('REFERENCE', GLEntry."External Document No.");
//                     AddExportString('NARRATION', GLEntry."Document No.");
//                     AddExportString('PERSISTEDVIEW', 'Accounting Voucher View');
//                     AddExportString('PARTYLEDGERNAME', MasterName);
//                     AddExportString('VOUCHERTYPENAME', InDocType);
//                 end;

//                 XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//                 AddExportString('LEDGERNAME', MasterName);
//                 AddExportString('ISPARTYLEDGER', IsPartyLedger);
//                 if GLEntry.Amount > 0 then begin
//                     AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('AMOUNT', Format(-GLEntry.Amount));
//                 end else begin
//                     AddExportString('ISDEEMEDPOSITIVE', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                     AddExportString('AMOUNT', Format(-GLEntry.Amount));
//                 end;
//                 XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//             until GLEntry.Next = 0;

//         XMLValues := XMLValues + '</VOUCHER>';
//     end;

//     local procedure GenerateXMlDocForTallyContra(InLocCode: Text; InSourceCode: Text; InPostingDate: Date; InDoctNo: Text; InDocType: Text; InTxnType: Text)
//     var
//         GLEntry: Record "G/L Entry";
//         DocLineNo: Integer;
//         BankAcct: Record "Bank Account";
//         CustAcct: Record Customer;
//         VendAcct: Record Vendor;
//         FAAcct: Record "Fixed Asset";
//         IsPartyLedger: Text;
//     begin
//         DocLineNo := 0;
//         GLEntry.Reset;
//         GLEntry.SetCurrentkey(Amount);
//         //GLEntry.SETASCENDING(Amount,FALSE);
//         //GLEntry.SETFILTER("Location Code",InLocCode);
//         GLEntry.SetFilter("Source Code", InSourceCode);
//         GLEntry.SetRange("Posting Date", InPostingDate);
//         GLEntry.SetFilter("Document No.", InDoctNo);
//         if GLEntry.FindFirst then
//             repeat
//                 GLEntry.CalcFields("G/L Account Name");
//                 DocLineNo := DocLineNo + 1;

//                 MasterName := '';
//                 VarCode := GLEntry."G/L Account No.";
//                 VarName := GLEntry."G/L Account Name";
//                 //MasterName:=VarCode+'-'+VarName;
//                 IsPartyLedger := 'No';

//                 if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"G/L Account" then begin
//                     if GLAcct.Get(GLEntry."Bal. Account No.") then;
//                     VarCode := GLAcct."No.";
//                     VarName := GLAcct.Name;
//                 end else
//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"Bank Account" then begin
//                         if BankAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := BankAcct."No.";
//                         VarName := BankAcct.Name;
//                     end else
//                         if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::Customer then begin
//                             if CustAcct.Get(GLEntry."Bal. Account No.") then;
//                             VarCode := CustAcct."No.";
//                             VarName := CustAcct.Name;
//                             IsPartyLedger := 'Yes';
//                         end else
//                             if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::Vendor then begin
//                                 if VendAcct.Get(GLEntry."Bal. Account No.") then;
//                                 VarCode := VendAcct."No.";
//                                 VarName := VendAcct.Name;
//                                 IsPartyLedger := 'Yes';
//                             end else
//                                 if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"Fixed Asset" then begin
//                                     if FAAcct.Get(GLEntry."Bal. Account No.") then;
//                                     VarCode := FAAcct."No.";
//                                     VarName := FAAcct.Description;
//                                 end;

//                 if MasterNaming = Masternaming::Code then
//                     MasterName := VarCode
//                 else
//                     if MasterNaming = Masternaming::Name then
//                         MasterName := VarName
//                     else
//                         MasterName := VarCode + '-' + VarName;

//                 MasterName := ConvertMasterName(MasterName);

//                 if DocLineNo = 1 then begin
//                     XMLValues := XMLValues + '<VOUCHER VCHTYPE="' + InTxnType + '" ACTION="Create" OBJVIEW="Accounting Voucher View">';
//                     AddExportString('DATE', ConvertTallyDate(GLEntry."Posting Date"));
//                     AddExportString('EFFECTIVEDATE', ConvertTallyDate(GLEntry."Posting Date"));
//                     AddExportString('VOUCHERNUMBER', GLEntry."Document No.");
//                     AddExportString('REFERENCE', GLEntry."External Document No.");
//                     AddExportString('NARRATION', GLEntry."Document No.");
//                     AddExportString('PERSISTEDVIEW', 'Accounting Voucher View');
//                     AddExportString('PARTYLEDGERNAME', MasterName);
//                     AddExportString('VOUCHERTYPENAME', InDocType);
//                 end;

//                 XMLValues := XMLValues + '<LEDGERENTRIES.LIST>';
//                 AddExportString('LEDGERNAME', MasterName);
//                 AddExportString('ISPARTYLEDGER', IsPartyLedger);
//                 if GLEntry.Amount > 0 then begin
//                     AddExportString('ISDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'Yes');
//                     AddExportString('AMOUNT', Format(-GLEntry.Amount));
//                 end else begin
//                     AddExportString('ISDEEMEDPOSITIVE', 'No');
//                     AddExportString('ISLASTDEEMEDPOSITIVE', 'No');
//                     AddExportString('AMOUNT', Format(-GLEntry.Amount));
//                 end;
//                 XMLValues := XMLValues + '</LEDGERENTRIES.LIST>';
//             until GLEntry.Next = 0;

//         XMLValues := XMLValues + '</VOUCHER>';
//     end;

//     local procedure ExportAllSalesInvoiceMasters()
//     begin

//         CreateMasterXMLHeader;
//         CreateSalesInvoiceLedgerXml;
//         CreateMasterXMLFooter;
//         CallPOSTService;

//         CreateMasterXMLHeader;
//         CreateSalesInvoiceStockGroupXml;

//         CreateMasterXMLFooter;
//         CallPOSTService;

//         CreateMasterXMLHeader;
//         CreateSalesInvoiceStockCategoryXml;

//         CreateMasterXMLFooter;
//         CallPOSTService;

//         CreateMasterXMLHeader;
//         CreateSalesInvoiceStockUnitXml;

//         CreateMasterXMLFooter;
//         CallPOSTService;

//         CreateMasterXMLHeader;
//         CreateSalesInvoiceStockItemXml;

//         CreateMasterXMLFooter;


//         CallPOSTService;

//         CreateMasterXMLHeader;
//         CreateSalesInvoiceGodownXml;

//         CreateMasterXMLFooter;
//         CallPOSTService;
//     end;

//     local procedure ExportAllSalesCrMemoMasters()
//     begin
//         CreateMasterXMLHeader;

//         CreateSalesCrMemoLedgerXml;
//         CreateSalesCrMemoStockGroupXml;
//         CreateSalesCrMemoStockCategoryXml;
//         CreateSalesCrMemoStockUnitXml;
//         CreateSalesCrMemoStockItemXml;
//         CreateSalesCrMemoGodownXml;

//         CreateMasterXMLFooter;
//         CallPOSTService;
//     end;

//     local procedure ExportAllPurchaseInvoiceMasters()
//     begin
//         CreateMasterXMLHeader;

//         CreatePurchaseInvoiceLedgerXml;
//         CreatePurchaseInvoiceStockGroupXml;
//         CreatePurchaseInvoiceStockCategoryXml;
//         CreatePurchaseInvoiceStockUnitXml;
//         CreatePurchaseInvoiceStockItemXml;
//         CreatePurchaseInvoiceGodownXml;

//         CreateMasterXMLFooter;
//         CallPOSTService;
//     end;

//     local procedure ExportAllPurchaseCrMemoMasters()
//     begin
//         CreateMasterXMLHeader;

//         CreatePurchaseCrMemoLedgerXml;
//         CreatePurchaseCrMemoStockGroupXml;
//         CreatePurchaseCrMemoStockCategoryXml;
//         CreatePurchaseCrMemoStockUnitXml;
//         CreatePurchaseCrMemoStockItemXml;
//         CreatePurchaseCrMemoGodownXml;

//         CreateMasterXMLFooter;
//         CallPOSTService;
//     end;

//     local procedure ExportAllPaymentMasters()
//     var
//         GLEntry: Record "G/L Entry";
//         CurrMasterKey: Text;
//         PrevMasterKey: Text;
//         VarGroup: Text;
//         GJTemp: Record "Gen. Journal Template";
//         CustAcct: Record Customer;
//         VendAcct: Record Vendor;
//         AllSourceCode: Text;
//         IsPartyLedger: Text;
//         BankAcct: Record "Bank Account";
//         FAAcct: Record "Fixed Asset";
//     begin
//         CreateMasterXMLHeader;

//         CurrMasterKey := '';
//         PrevMasterKey := '';
//         AllSourceCode := '';

//         GJTemp.Reset;
//         GJTemp.SetFilter(GJTemp."Sub Type", '%1|%2', GJTemp."sub type"::"Cash Payment Voucher", GJTemp."sub type"::"Bank Payment Voucher");
//         GJTemp.SetFilter(Type, '%1|%2', GJTemp.Type::General, GJTemp.Type::Payments);
//         if GJTemp.FindFirst then
//             repeat
//                 if AllSourceCode = '' then
//                     AllSourceCode := GJTemp."Source Code"
//                 else
//                     AllSourceCode := AllSourceCode + '|' + GJTemp."Source Code";
//             until GJTemp.Next = 0;

//         GLEntry.Reset;
//         GLEntry.SetCurrentkey(GLEntry."Bal. Account Type", GLEntry."Bal. Account No.");
//         //GLEntry.SETFILTER("Location Code",LocCode);
//         GLEntry.SetFilter("Source Code", AllSourceCode);
//         GLEntry.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             GLEntry.SetFilter("Document No.", VarDoctNo);
//         GLEntry.SetFilter("Bal. Account No.", '<>%1', '');
//         if GLEntry.FindFirst then
//             repeat
//                 CurrMasterKey := Format(GLEntry."Bal. Account Type") + '-' + GLEntry."Bal. Account No.";
//                 if CurrMasterKey <> PrevMasterKey then begin
//                     MasterName := '';
//                     VarCode := GLEntry."Source No.";
//                     IsPartyLedger := 'No';
//                     VarGroup := '';

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"Bank Account" then begin
//                         if BankAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := BankAcct."No.";
//                         VarName := BankAcct.Name;
//                         VarGroup := 'Bank Accounts';
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"G/L Account" then begin
//                         if GLAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                         VarGroup := Format(GLAcct."Tally Group Name");
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::Customer then begin
//                         if CustAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := CustAcct."No.";
//                         VarName := CustAcct.Name;
//                         IsPartyLedger := 'Yes';
//                         VarGroup := 'Sundry Debtors';
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::Vendor then begin
//                         if VendAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := VendAcct."No.";
//                         VarName := VendAcct.Name;
//                         IsPartyLedger := 'Yes';
//                         VarGroup := 'Sundry Creditors';
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"Fixed Asset" then begin
//                         if FAAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := FAAcct."No.";
//                         VarName := FAAcct.Description;
//                         VarGroup := 'Fixed Assets';
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', VarGroup);

//                     if IsPartyLedger = 'Yes' then begin
//                         if VarGroup = 'Sundry Debtors' then begin
//                             AddExportString('ISBILLWISEON', 'YES');
//                             AddExportString('BILLCREDITPERIOD', CustAcct."Payment Terms Code");
//                             AddExportString('MAILINGNAME', CustAcct.Name);
//                             if Cust.Address <> '' then begin
//                                 XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                                 AddExportString('ADDRESS', CustAcct.Address);
//                                 AddExportString('ADDRESS', CustAcct."Address 2");
//                                 XMLValues := XMLValues + '</ADDRESS.LIST>';
//                             end;
//                             AddExportString('LEDSTATENAME', GETTallyStateName(CustAcct."State Code"));
//                             AddExportString('PINCODE', CustAcct."Post Code");
//                             AddExportString('COUNTRYNAME', GETTallyCountryName(CustAcct."Country/Region Code"));
//                             AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(CustAcct."Country/Region Code"));
//                             AddExportString('LEDGERCONTACT', CustAcct.Contact);
//                             AddExportString('LEDGERPHONE', CustAcct."Phone No.");
//                             AddExportString('LEDGERFAX', CustAcct."Fax No.");
//                             AddExportString('LEDGERMOBILE', CustAcct."Phone No.");
//                             AddExportString('EMAIL', CustAcct."E-Mail");
//                             AddExportString('EMAILCC', CustAcct."E-Mail");
//                             AddExportString('WEBSITE', CustAcct."Home Page");
//                             AddExportString('INCOMETAXNUMBER', CustAcct."P.A.N. No.");
//                             AddExportString('GSTREGISTRATIONTYPE', Format(CustAcct."GST Customer Type"));
//                             AddExportString('PARTYGSTIN', CustAcct."GST Registration No.");
//                         end else
//                             if VarGroup = 'Sundry Creditors' then begin
//                                 AddExportString('ISBILLWISEON', 'YES');
//                                 AddExportString('BILLCREDITPERIOD', VendAcct."Payment Terms Code");
//                                 AddExportString('MAILINGNAME', VendAcct.Name);
//                                 if Cust.Address <> '' then begin
//                                     XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                                     AddExportString('ADDRESS', VendAcct.Address);
//                                     AddExportString('ADDRESS', VendAcct."Address 2");
//                                     XMLValues := XMLValues + '</ADDRESS.LIST>';
//                                 end;
//                                 AddExportString('LEDSTATENAME', GETTallyStateName(VendAcct."State Code"));
//                                 AddExportString('PINCODE', VendAcct."Post Code");
//                                 AddExportString('COUNTRYNAME', GETTallyCountryName(VendAcct."Country/Region Code"));
//                                 AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(VendAcct."Country/Region Code"));
//                                 AddExportString('LEDGERCONTACT', VendAcct.Contact);
//                                 AddExportString('LEDGERPHONE', VendAcct."Phone No.");
//                                 AddExportString('LEDGERFAX', VendAcct."Fax No.");
//                                 AddExportString('LEDGERMOBILE', VendAcct."Phone No.");
//                                 AddExportString('EMAIL', VendAcct."E-Mail");
//                                 AddExportString('EMAILCC', VendAcct."E-Mail");
//                                 AddExportString('WEBSITE', VendAcct."Home Page");
//                                 AddExportString('INCOMETAXNUMBER', VendAcct."P.A.N. No.");
//                                 AddExportString('GSTREGISTRATIONTYPE', Format(VendAcct."GST Vendor Type"));
//                                 AddExportString('PARTYGSTIN', VendAcct."GST Registration No.");
//                             end;
//                     end;
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevMasterKey := Format(GLEntry."Bal. Account Type") + '-' + GLEntry."Bal. Account No.";
//                 ;
//             until GLEntry.Next = 0;

//         CurrMasterKey := '';
//         PrevMasterKey := '';


//         GLEntry.Reset;
//         GLEntry.SetCurrentkey("G/L Account No.");
//         //GLEntry.SETFILTER("Location Code",LocCode);
//         GLEntry.SetFilter("Source Code", AllSourceCode);
//         GLEntry.SetRange("Posting Date", StartDate, EndDate);
//         GLEntry.SetRange("Source No.", '');
//         if VarDoctNo <> '' then
//             GLEntry.SetFilter("Document No.", VarDoctNo);
//         GLEntry.SetFilter("G/L Account No.", '<>%1', '');
//         if GLEntry.FindFirst then
//             repeat
//                 CurrMasterKey := GLEntry."G/L Account No.";
//                 if CurrMasterKey <> PrevMasterKey then begin
//                     MasterName := '';
//                     VarCode := GLEntry."G/L Account No.";
//                     IsPartyLedger := 'No';
//                     VarGroup := '';
//                     if GLAcct.Get(GLEntry."G/L Account No.") then;
//                     VarCode := GLAcct."No.";
//                     VarName := GLAcct.Name;
//                     VarGroup := Format(GLAcct."Tally Group Name");

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;
//                     MasterName := ConvertMasterName(MasterName);
//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', VarGroup);
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevMasterKey := GLEntry."G/L Account No.";
//             until GLEntry.Next = 0;


//         CreateMasterXMLFooter;
//         CallPOSTService;
//     end;

//     local procedure ExportAllReceiptMasters()
//     var
//         GLEntry: Record "G/L Entry";
//         CurrMasterKey: Text;
//         PrevMasterKey: Text;
//         VarGroup: Text;
//         GJTemp: Record "Gen. Journal Template";
//         CustAcct: Record Customer;
//         VendAcct: Record Vendor;
//         AllSourceCode: Text;
//         IsPartyLedger: Text;
//         BankAcct: Record "Bank Account";
//         FAAcct: Record "Fixed Asset";
//     begin
//         CreateMasterXMLHeader;

//         CurrMasterKey := '';
//         PrevMasterKey := '';
//         AllSourceCode := '';

//         GJTemp.Reset;
//         GJTemp.SetFilter(GJTemp."Sub Type", '%1|%2', GJTemp."sub type"::"Cash Receipt Voucher", GJTemp."sub type"::"Bank Receipt Voucher");
//         GJTemp.SetFilter(Type, '%1|%2', GJTemp.Type::General, GJTemp.Type::"Cash Receipts");
//         if GJTemp.FindFirst then
//             repeat
//                 if AllSourceCode = '' then
//                     AllSourceCode := GJTemp."Source Code"
//                 else
//                     AllSourceCode := AllSourceCode + '|' + GJTemp."Source Code";
//             until GJTemp.Next = 0;

//         GLEntry.Reset;
//         GLEntry.SetCurrentkey(GLEntry."Bal. Account Type", GLEntry."Bal. Account No.");
//         //GLEntry.SETFILTER("Location Code",LocCode);
//         GLEntry.SetFilter("Source Code", AllSourceCode);
//         GLEntry.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             GLEntry.SetFilter("Document No.", VarDoctNo);
//         GLEntry.SetFilter("Bal. Account No.", '<>%1', '');
//         if GLEntry.FindFirst then
//             repeat
//                 CurrMasterKey := Format(GLEntry."Bal. Account Type") + '-' + GLEntry."Bal. Account No.";
//                 if CurrMasterKey <> PrevMasterKey then begin
//                     MasterName := '';
//                     VarCode := GLEntry."Source No.";
//                     IsPartyLedger := 'No';
//                     VarGroup := '';

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"G/L Account" then begin
//                         if GLAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                         VarGroup := Format(GLAcct."Tally Group Name");
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"Bank Account" then begin
//                         if BankAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := BankAcct."No.";
//                         VarName := BankAcct.Name;
//                         VarGroup := 'Bank Accounts';
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::Customer then begin
//                         if CustAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := CustAcct."No.";
//                         VarName := CustAcct.Name;
//                         IsPartyLedger := 'Yes';
//                         VarGroup := 'Sundry Debtors';
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::Vendor then begin
//                         if VendAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := VendAcct."No.";
//                         VarName := VendAcct.Name;
//                         IsPartyLedger := 'Yes';
//                         VarGroup := 'Sundry Creditors';
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"Fixed Asset" then begin
//                         if FAAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := FAAcct."No.";
//                         VarName := FAAcct.Description;
//                         VarGroup := 'Fixed Assets';
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', VarGroup);

//                     if IsPartyLedger = 'Yes' then begin
//                         if VarGroup = 'Sundry Debtors' then begin
//                             AddExportString('ISBILLWISEON', 'YES');
//                             AddExportString('BILLCREDITPERIOD', CustAcct."Payment Terms Code");
//                             AddExportString('MAILINGNAME', CustAcct.Name);
//                             if Cust.Address <> '' then begin
//                                 XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                                 AddExportString('ADDRESS', CustAcct.Address);
//                                 AddExportString('ADDRESS', CustAcct."Address 2");
//                                 XMLValues := XMLValues + '</ADDRESS.LIST>';
//                             end;
//                             AddExportString('LEDSTATENAME', GETTallyStateName(CustAcct."State Code"));
//                             AddExportString('PINCODE', CustAcct."Post Code");
//                             AddExportString('COUNTRYNAME', GETTallyCountryName(CustAcct."Country/Region Code"));
//                             AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(CustAcct."Country/Region Code"));
//                             AddExportString('LEDGERCONTACT', CustAcct.Contact);
//                             AddExportString('LEDGERPHONE', CustAcct."Phone No.");
//                             AddExportString('LEDGERFAX', CustAcct."Fax No.");
//                             AddExportString('LEDGERMOBILE', CustAcct."Phone No.");
//                             AddExportString('EMAIL', CustAcct."E-Mail");
//                             AddExportString('EMAILCC', CustAcct."E-Mail");
//                             AddExportString('WEBSITE', CustAcct."Home Page");
//                             AddExportString('INCOMETAXNUMBER', CustAcct."P.A.N. No.");
//                             AddExportString('GSTREGISTRATIONTYPE', Format(CustAcct."GST Customer Type"));
//                             AddExportString('PARTYGSTIN', CustAcct."GST Registration No.");
//                         end else
//                             if VarGroup = 'Sundry Creditors' then begin
//                                 AddExportString('ISBILLWISEON', 'YES');
//                                 AddExportString('BILLCREDITPERIOD', VendAcct."Payment Terms Code");
//                                 AddExportString('MAILINGNAME', VendAcct.Name);
//                                 if Cust.Address <> '' then begin
//                                     XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                                     AddExportString('ADDRESS', VendAcct.Address);
//                                     AddExportString('ADDRESS', VendAcct."Address 2");
//                                     XMLValues := XMLValues + '</ADDRESS.LIST>';
//                                 end;
//                                 AddExportString('LEDSTATENAME', GETTallyStateName(VendAcct."State Code"));
//                                 AddExportString('PINCODE', VendAcct."Post Code");
//                                 AddExportString('COUNTRYNAME', GETTallyCountryName(VendAcct."Country/Region Code"));
//                                 AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(VendAcct."Country/Region Code"));
//                                 AddExportString('LEDGERCONTACT', VendAcct.Contact);
//                                 AddExportString('LEDGERPHONE', VendAcct."Phone No.");
//                                 AddExportString('LEDGERFAX', VendAcct."Fax No.");
//                                 AddExportString('LEDGERMOBILE', VendAcct."Phone No.");
//                                 AddExportString('EMAIL', VendAcct."E-Mail");
//                                 AddExportString('EMAILCC', VendAcct."E-Mail");
//                                 AddExportString('WEBSITE', VendAcct."Home Page");
//                                 AddExportString('INCOMETAXNUMBER', VendAcct."P.A.N. No.");
//                                 AddExportString('GSTREGISTRATIONTYPE', Format(VendAcct."GST Vendor Type"));
//                                 AddExportString('PARTYGSTIN', VendAcct."GST Registration No.");
//                             end;
//                     end;
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevMasterKey := Format(GLEntry."Bal. Account Type") + '-' + GLEntry."Bal. Account No.";
//             until GLEntry.Next = 0;

//         CurrMasterKey := '';
//         PrevMasterKey := '';

//         GLEntry.Reset;
//         GLEntry.SetCurrentkey("G/L Account No.");
//         //GLEntry.SETFILTER("Location Code",LocCode);
//         GLEntry.SetFilter("Source Code", AllSourceCode);
//         GLEntry.SetRange("Posting Date", StartDate, EndDate);
//         GLEntry.SetRange("Source No.", '');
//         if VarDoctNo <> '' then
//             GLEntry.SetFilter("Document No.", VarDoctNo);
//         GLEntry.SetFilter("G/L Account No.", '<>%1', '');
//         if GLEntry.FindFirst then
//             repeat
//                 CurrMasterKey := GLEntry."G/L Account No.";
//                 if CurrMasterKey <> PrevMasterKey then begin
//                     MasterName := '';
//                     VarCode := GLEntry."G/L Account No.";
//                     IsPartyLedger := 'No';
//                     VarGroup := '';
//                     if GLAcct.Get(GLEntry."G/L Account No.") then;
//                     VarCode := GLAcct."No.";
//                     VarName := GLAcct.Name;
//                     VarGroup := Format(GLAcct."Tally Group Name");

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;
//                     MasterName := ConvertMasterName(MasterName);
//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', VarGroup);
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevMasterKey := GLEntry."G/L Account No.";
//             until GLEntry.Next = 0;


//         CreateMasterXMLFooter;
//         CallPOSTService;
//     end;

//     local procedure ExportAllJournalMasters()
//     var
//         GLEntry: Record "G/L Entry";
//         CurrMasterKey: Text;
//         PrevMasterKey: Text;
//         VarGroup: Text;
//         GJTemp: Record "Gen. Journal Template";
//         CustAcct: Record Customer;
//         VendAcct: Record Vendor;
//         AllSourceCode: Text;
//         IsPartyLedger: Text;
//         BankAcct: Record "Bank Account";
//         FAAcct: Record "Fixed Asset";
//     begin
//         CreateMasterXMLHeader;

//         CurrMasterKey := '';
//         PrevMasterKey := '';
//         AllSourceCode := 'REVERSAL';

//         GJTemp.Reset;
//         GJTemp.SetFilter(GJTemp."Sub Type", '%1', GJTemp."sub type"::"Journal Voucher");
//         GJTemp.SetFilter(Type, '%1', GJTemp.Type::General);
//         if GJTemp.FindFirst then
//             repeat
//                 if AllSourceCode = '' then
//                     AllSourceCode := GJTemp."Source Code"
//                 else
//                     AllSourceCode := AllSourceCode + '|' + GJTemp."Source Code";
//             until GJTemp.Next = 0;

//         /*
//         GLEntry.RESET;
//         GLEntry.SETCURRENTKEY(GLEntry."Bal. Account Type",GLEntry."Bal. Account No.");
//         //GLEntry.SETFILTER("Location Code",LocCode);
//         GLEntry.SETFILTER("Source Code",AllSourceCode);
//         GLEntry.SETRANGE("Posting Date",StartDate,EndDate);
//         IF VarDoctNo<>'' THEN
//         GLEntry.SETFILTER("Document No.",VarDoctNo);
//         GLEntry.SETFILTER("Source No.",'<>%1','');
//         IF GLEntry.FINDFIRST THEN REPEAT
//           CurrMasterKey:=FORMAT(GLEntry."Bal. Account Type")+'-'+GLEntry."Bal. Account No.";
//           IF CurrMasterKey<>PrevMasterKey THEN BEGIN
//             MasterName:='';
//             VarCode:=GLEntry."Source No.";
//             IsPartyLedger:='No';
//             VarGroup:='';

//             IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::"G/L Account" THEN BEGIN
//               IF GLAcct.GET(GLEntry."Bal. Account No.") THEN ;
//               VarCode:=GLAcct."No.";
//               VarName:=GLAcct.Name;
//               VarGroup:=FORMAT(GLAcct."Tally Group Name");
//             END;

//             IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::"Bank Account" THEN BEGIN
//               IF BankAcct.GET(GLEntry."Bal. Account No.") THEN ;
//               VarCode:=BankAcct."No.";
//               VarName:=BankAcct.Name;
//               VarGroup:='Bank Accounts';
//             END;

//             IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::Customer THEN BEGIN
//               IF CustAcct.GET(GLEntry."Bal. Account No.") THEN ;
//               VarCode:=CustAcct."No.";
//               VarName:=CustAcct.Name;
//               IsPartyLedger:='Yes';
//               VarGroup:='Sundry Debtors';
//             END;

//             IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::Vendor THEN BEGIN
//               IF VendAcct.GET(GLEntry."Bal. Account No.") THEN ;
//               VarCode:=VendAcct."No.";
//               VarName:=VendAcct.Name;
//               IsPartyLedger:='Yes';
//               VarGroup:='Sundry Creditors';
//             END;

//             IF GLEntry."Bal. Account Type"=GLEntry."Bal. Account Type"::"Fixed Asset" THEN BEGIN
//               IF FAAcct.GET(GLEntry."Bal. Account No.") THEN ;
//               VarCode:=FAAcct."No.";
//               VarName:=FAAcct.Description;
//               VarGroup:='Fixed Assets';
//             END;

//             IF MasterNaming=MasterNaming::Code THEN
//               MasterName:=VarCode
//             ELSE IF MasterNaming=MasterNaming::Name THEN
//               MasterName:=VarName
//             ELSE
//               MasterName:=VarCode+'-'+VarName;

//             MasterName:=ConvertMasterName(MasterName);

//             XMLValues:=XMLValues+'<LEDGER NAME="'+MasterName+'" RESERVEDNAME="">';
//             AddExportString('NAME',MasterName);
//             AddExportString('PARENT',VarGroup);

//             IF IsPartyLedger='Yes' THEN BEGIN
//               IF VarGroup='Sundry Debtors' THEN BEGIN
//                 AddExportString('ISBILLWISEON','YES');
//                 AddExportString('BILLCREDITPERIOD',CustAcct."Payment Terms Code");
//                 AddExportString('MAILINGNAME',CustAcct.Name);
//                 IF Cust.Address<>'' THEN BEGIN
//                   XMLValues:=XMLValues+'<ADDRESS.LIST TYPE="String">';
//                   AddExportString('ADDRESS',CustAcct.Address);
//                   AddExportString('ADDRESS',CustAcct."Address 2");
//                   XMLValues:=XMLValues+'</ADDRESS.LIST>';
//                 END;
//                 AddExportString('LEDSTATENAME',GETTallyStateName(CustAcct."State Code"));
//                 AddExportString('PINCODE',CustAcct."Post Code");
//                 AddExportString('COUNTRYNAME',GETTallyCountryName(CustAcct."Country/Region Code"));
//                 AddExportString('COUNTRYOFRESIDENCE',GETTallyCountryName(CustAcct."Country/Region Code"));
//                 AddExportString('LEDGERCONTACT',CustAcct.Contact);
//                 AddExportString('LEDGERPHONE',CustAcct."Phone No.");
//                 AddExportString('LEDGERFAX',CustAcct."Fax No.");
//                 AddExportString('LEDGERMOBILE',CustAcct."Phone No.");
//                 AddExportString('EMAIL',CustAcct."E-Mail");
//                 AddExportString('EMAILCC',CustAcct."E-Mail");
//                 AddExportString('WEBSITE',CustAcct."Home Page");
//                 AddExportString('INCOMETAXNUMBER',CustAcct."P.A.N. No.");
//                 AddExportString('GSTREGISTRATIONTYPE',FORMAT(CustAcct."GST Customer Type"));
//                 AddExportString('PARTYGSTIN',CustAcct."GST Registration No.");
//               END ELSE IF VarGroup='Sundry Creditors' THEN BEGIN
//                 AddExportString('ISBILLWISEON','YES');
//                 AddExportString('BILLCREDITPERIOD',VendAcct."Payment Terms Code");
//                 AddExportString('MAILINGNAME',VendAcct.Name);
//                 IF Cust.Address<>'' THEN BEGIN
//                   XMLValues:=XMLValues+'<ADDRESS.LIST TYPE="String">';
//                   AddExportString('ADDRESS',VendAcct.Address);
//                   AddExportString('ADDRESS',VendAcct."Address 2");
//                   XMLValues:=XMLValues+'</ADDRESS.LIST>';
//                 END;
//                 AddExportString('LEDSTATENAME',GETTallyStateName(VendAcct."State Code"));
//                 AddExportString('PINCODE',VendAcct."Post Code");
//                 AddExportString('COUNTRYNAME',GETTallyCountryName(VendAcct."Country/Region Code"));
//                 AddExportString('COUNTRYOFRESIDENCE',GETTallyCountryName(VendAcct."Country/Region Code"));
//                 AddExportString('LEDGERCONTACT',VendAcct.Contact);
//                 AddExportString('LEDGERPHONE',VendAcct."Phone No.");
//                 AddExportString('LEDGERFAX',VendAcct."Fax No.");
//                 AddExportString('LEDGERMOBILE',VendAcct."Phone No.");
//                 AddExportString('EMAIL',VendAcct."E-Mail");
//                 AddExportString('EMAILCC',VendAcct."E-Mail");
//                 AddExportString('WEBSITE',VendAcct."Home Page");
//                 AddExportString('INCOMETAXNUMBER',VendAcct."P.A.N. No.");
//                 AddExportString('GSTREGISTRATIONTYPE',FORMAT(VendAcct."GST Vendor Type"));
//                 AddExportString('PARTYGSTIN',VendAcct."GST Registration No.");
//               END;
//             END;
//             XMLValues:=XMLValues+'</LEDGER>';
//           END;
//           PrevMasterKey:=FORMAT(GLEntry."Bal. Account Type")+'-'+GLEntry."Bal. Account No.";
//         UNTIL GLEntry.NEXT=0;
//         */

//         CurrMasterKey := '';
//         PrevMasterKey := '';

//         GLEntry.Reset;
//         GLEntry.SetCurrentkey("G/L Account No.");
//         //GLEntry.SETFILTER("Location Code",LocCode);
//         GLEntry.SetFilter("Source Code", AllSourceCode);
//         GLEntry.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             GLEntry.SetFilter("Document No.", VarDoctNo);
//         GLEntry.SetFilter("G/L Account No.", '<>%1', '');
//         if GLEntry.FindFirst then
//             repeat
//                 GLEntry.CalcFields("G/L Account Name");
//                 CurrMasterKey := GLEntry."G/L Account No.";
//                 if CurrMasterKey <> PrevMasterKey then begin
//                     MasterName := '';
//                     VarCode := GLEntry."G/L Account No.";
//                     VarName := GLEntry."G/L Account Name";
//                     VarGroup := Format(GLAcct."Tally Group Name");

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);
//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', VarGroup);
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevMasterKey := GLEntry."G/L Account No.";
//             until GLEntry.Next = 0;


//         CreateMasterXMLFooter;
//         CallPOSTService;

//     end;

//     local procedure ExportAllContraMasters()
//     var
//         GLEntry: Record "G/L Entry";
//         CurrMasterKey: Text;
//         PrevMasterKey: Text;
//         VarGroup: Text;
//         GJTemp: Record "Gen. Journal Template";
//         CustAcct: Record Customer;
//         VendAcct: Record Vendor;
//         AllSourceCode: Text;
//         IsPartyLedger: Text;
//         BankAcct: Record "Bank Account";
//         FAAcct: Record "Fixed Asset";
//     begin
//         CreateMasterXMLHeader;

//         CurrMasterKey := '';
//         PrevMasterKey := '';
//         AllSourceCode := '';

//         GJTemp.Reset;
//         GJTemp.SetFilter(GJTemp."Sub Type", '%1', GJTemp."sub type"::"Contra Voucher");
//         GJTemp.SetFilter(Type, '%1', GJTemp.Type::General);
//         if GJTemp.FindFirst then
//             repeat
//                 if AllSourceCode = '' then
//                     AllSourceCode := GJTemp."Source Code"
//                 else
//                     AllSourceCode := AllSourceCode + '|' + GJTemp."Source Code";
//             until GJTemp.Next = 0;

//         GLEntry.Reset;
//         GLEntry.SetCurrentkey(GLEntry."Bal. Account Type", GLEntry."Bal. Account No.");
//         //GLEntry.SETFILTER("Location Code",LocCode);
//         GLEntry.SetFilter("Source Code", AllSourceCode);
//         GLEntry.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             GLEntry.SetFilter("Document No.", VarDoctNo);
//         GLEntry.SetFilter("Source No.", '<>%1', '');
//         if GLEntry.FindFirst then
//             repeat
//                 CurrMasterKey := Format(GLEntry."Bal. Account Type") + '-' + GLEntry."Bal. Account No.";
//                 if CurrMasterKey <> PrevMasterKey then begin
//                     MasterName := '';
//                     VarCode := GLEntry."Source No.";
//                     IsPartyLedger := 'No';
//                     VarGroup := '';

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"G/L Account" then begin
//                         if GLAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                         VarGroup := Format(GLAcct."Tally Group Name");
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"Bank Account" then begin
//                         if BankAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := BankAcct."No.";
//                         VarName := BankAcct.Name;
//                         VarGroup := 'Bank Accounts';
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::Customer then begin
//                         if CustAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := CustAcct."No.";
//                         VarName := CustAcct.Name;
//                         IsPartyLedger := 'Yes';
//                         VarGroup := 'Sundry Debtors';
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::Vendor then begin
//                         if VendAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := VendAcct."No.";
//                         VarName := VendAcct.Name;
//                         IsPartyLedger := 'Yes';
//                         VarGroup := 'Sundry Creditors';
//                     end;

//                     if GLEntry."Bal. Account Type" = GLEntry."bal. account type"::"Fixed Asset" then begin
//                         if FAAcct.Get(GLEntry."Bal. Account No.") then;
//                         VarCode := FAAcct."No.";
//                         VarName := FAAcct.Description;
//                         VarGroup := 'Fixed Assets';
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', VarGroup);

//                     if IsPartyLedger = 'Yes' then begin
//                         if VarGroup = 'Sundry Debtors' then begin
//                             AddExportString('ISBILLWISEON', 'YES');
//                             AddExportString('BILLCREDITPERIOD', CustAcct."Payment Terms Code");
//                             AddExportString('MAILINGNAME', CustAcct.Name);
//                             if Cust.Address <> '' then begin
//                                 XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                                 AddExportString('ADDRESS', CustAcct.Address);
//                                 AddExportString('ADDRESS', CustAcct."Address 2");
//                                 XMLValues := XMLValues + '</ADDRESS.LIST>';
//                             end;
//                             AddExportString('LEDSTATENAME', GETTallyStateName(CustAcct."State Code"));
//                             AddExportString('PINCODE', CustAcct."Post Code");
//                             AddExportString('COUNTRYNAME', GETTallyCountryName(CustAcct."Country/Region Code"));
//                             AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(CustAcct."Country/Region Code"));
//                             AddExportString('LEDGERCONTACT', CustAcct.Contact);
//                             AddExportString('LEDGERPHONE', CustAcct."Phone No.");
//                             AddExportString('LEDGERFAX', CustAcct."Fax No.");
//                             AddExportString('LEDGERMOBILE', CustAcct."Phone No.");
//                             AddExportString('EMAIL', CustAcct."E-Mail");
//                             AddExportString('EMAILCC', CustAcct."E-Mail");
//                             AddExportString('WEBSITE', CustAcct."Home Page");
//                             AddExportString('INCOMETAXNUMBER', CustAcct."P.A.N. No.");
//                             AddExportString('GSTREGISTRATIONTYPE', Format(CustAcct."GST Customer Type"));
//                             AddExportString('PARTYGSTIN', CustAcct."GST Registration No.");
//                         end else
//                             if VarGroup = 'Sundry Creditors' then begin
//                                 AddExportString('ISBILLWISEON', 'YES');
//                                 AddExportString('BILLCREDITPERIOD', VendAcct."Payment Terms Code");
//                                 AddExportString('MAILINGNAME', VendAcct.Name);
//                                 if Cust.Address <> '' then begin
//                                     XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                                     AddExportString('ADDRESS', VendAcct.Address);
//                                     AddExportString('ADDRESS', VendAcct."Address 2");
//                                     XMLValues := XMLValues + '</ADDRESS.LIST>';
//                                 end;
//                                 AddExportString('LEDSTATENAME', GETTallyStateName(VendAcct."State Code"));
//                                 AddExportString('PINCODE', VendAcct."Post Code");
//                                 AddExportString('COUNTRYNAME', GETTallyCountryName(VendAcct."Country/Region Code"));
//                                 AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(VendAcct."Country/Region Code"));
//                                 AddExportString('LEDGERCONTACT', VendAcct.Contact);
//                                 AddExportString('LEDGERPHONE', VendAcct."Phone No.");
//                                 AddExportString('LEDGERFAX', VendAcct."Fax No.");
//                                 AddExportString('LEDGERMOBILE', VendAcct."Phone No.");
//                                 AddExportString('EMAIL', VendAcct."E-Mail");
//                                 AddExportString('EMAILCC', VendAcct."E-Mail");
//                                 AddExportString('WEBSITE', VendAcct."Home Page");
//                                 AddExportString('INCOMETAXNUMBER', VendAcct."P.A.N. No.");
//                                 AddExportString('GSTREGISTRATIONTYPE', Format(VendAcct."GST Vendor Type"));
//                                 AddExportString('PARTYGSTIN', VendAcct."GST Registration No.");
//                             end;
//                     end;
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevMasterKey := Format(GLEntry."Bal. Account Type") + '-' + GLEntry."Bal. Account No.";
//             until GLEntry.Next = 0;

//         CurrMasterKey := '';
//         PrevMasterKey := '';


//         GLEntry.Reset;
//         GLEntry.SetCurrentkey("G/L Account No.");
//         //GLEntry.SETFILTER("Location Code",LocCode);
//         GLEntry.SetFilter("Source Code", AllSourceCode);
//         GLEntry.SetRange("Posting Date", StartDate, EndDate);
//         GLEntry.SetRange("Source No.", '');
//         if VarDoctNo <> '' then
//             GLEntry.SetFilter("Document No.", VarDoctNo);
//         GLEntry.SetFilter("G/L Account No.", '<>%1', '');
//         if GLEntry.FindFirst then
//             repeat
//                 CurrMasterKey := GLEntry."G/L Account No.";
//                 if CurrMasterKey <> PrevMasterKey then begin
//                     MasterName := '';
//                     VarCode := GLEntry."G/L Account No.";
//                     IsPartyLedger := 'No';
//                     VarGroup := '';
//                     if GLAcct.Get(GLEntry."G/L Account No.") then;
//                     VarCode := GLAcct."No.";
//                     VarName := GLAcct.Name;
//                     VarGroup := Format(GLAcct."Tally Group Name");

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;
//                     MasterName := ConvertMasterName(MasterName);
//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', VarGroup);
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevMasterKey := GLEntry."G/L Account No.";
//             until GLEntry.Next = 0;


//         CreateMasterXMLFooter;
//         CallPOSTService;
//     end;

//     local procedure CreateTransactionXMLHeader()
//     begin
//         XMLValues := '<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>Vouchers</REPORTNAME>';
//         XMLValues := XMLValues + '<STATICVARIABLES><SVCURRENTCOMPANY>' + TallyCompanyName + '</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">';
//     end;

//     local procedure CreateTransactionXMLFooter()
//     begin
//         XMLValues := XMLValues + '</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>';
//     end;

//     local procedure CreateMasterXMLHeader()
//     begin
//         XMLValues := '<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME>';
//         XMLValues := XMLValues + '<STATICVARIABLES><IMPORTDUPS>Ignore Duplicates</IMPORTDUPS><SVCURRENTCOMPANY>' + TallyCompanyName + '</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">';

//         //XMLValues:='<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST><TYPE>Data</TYPE><ID>All Masters</ID></HEADER><BODY><DESC>';
//         //XMLValues:=XMLValues+'<STATICVARIABLES><IMPORTDUPS>@@DupIgnore</IMPORTDUPS><SVCURRENTCOMPANY>Navision Integration</SVCURRENTCOMPANY></STATICVARIABLES></DESC><DATA><TALLYMESSAGE>';
//         //<IMPORTDUPS>@@DupIgnore</IMPORTDUPS>
//         //Ignore Duplicates</IMPORTDUPS><SVCURRENTCOMPANY>Navision Integration</SVCURRENTCOMPANY></STATICVARIABLES></DESC><DATA><TALLYMESSAGE>';
//     end;

//     local procedure CreateMasterXMLFooter()
//     begin
//         //XMLValues:=XMLValues+'</TALLYMESSAGE></DATA></BODY></ENVELOPE>';
//         XMLValues := XMLValues + '</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>';
//     end;

//     local procedure ConvertTallyDate(InDate: Date): Text
//     begin
//         //EXIT('20180901');

//         if Format(InDate) = '' then
//             exit('')
//         else
//             exit(Format(InDate, 8, '<Year4><Month,2><Day,2>'));
//     end;

//     local procedure GETTallyStateName(InStateCode: Text): Text
//     var
//         StatesRec: Record State;
//         StateRec2: Record State;
//     begin
//         if LocRec.Get(LocCode) then;

//         if StateRec2.Get(LocRec."State Code") then;

//         StatesRec.Reset;
//         StatesRec.SetRange(Code, InStateCode);
//         if StatesRec.FindFirst then begin
//             StatesRec.TestField("Tally State Name");
//             exit(StatesRec."Tally State Name")
//         end else
//             exit(StateRec2."Tally State Name");
//     end;

//     local procedure GETTallyCountryName(InCountryCode: Text): Text
//     var
//         CountryRec: Record "Country/Region";
//     begin
//         CountryRec.Reset;
//         CountryRec.SetRange(Code, InCountryCode);
//         if CountryRec.FindFirst then begin
//             CountryRec.TestField("Tally Country Name");
//             exit(CountryRec."Tally Country Name")
//         end else
//             exit('India');
//     end;

//     local procedure GETGodownName(InLocCode: Text): Text
//     var
//         LocRec: Record Location;
//     begin
//         if LocRec.Get(InLocCode) then begin
//             if LocRec."Tally Godown Name" = '' then
//                 LocRec."Tally Godown Name" := LocRec.City;

//             LocRec.TestField("Tally Godown Name");
//             exit(LocRec."Tally Godown Name")
//         end else
//             exit('Main Location');
//     end;

//     local procedure CallPOSTService()
//     begin

//         FileLoc := 'E:\Tally Xml\' + Format(SYSTEM.Random(999999999)) + '.xml';
//         TxtFile.Create(FileLoc);
//         TxtFile.CreateOutstream(OutStreamObj);
//         OutStreamObj.WriteText(XMLValues);
//         TxtFile.Close;



//         if ISCLEAR(XMLHTTP) then
//             Create(XMLHTTP, true, true);

//         /*
//         IF ISCLEAR(XMLDoc) THEN
//         CREATE(XMLDoc,TRUE,TRUE);
//         XMLDoc.async := FALSE;
//         */


//         XMLHTTP.open('POST', TallyLinkUrl, false);
//         XMLHTTP.send(XMLValues);
//         //XMLDoc.loadXML(XMLHTTP.responseText);

//         //MESSAGE(XMLHTTP.responseText);

//     end;

//     local procedure AddNewLedgerString(InLedName: Text; InLedGroup: Text)
//     begin
//     end;

//     local procedure CreateSalesInvoiceLedgerXml()
//     var
//         SIH2: Record "Sales Invoice Header";
//         SIL: Record "Sales Invoice Line";
//         GSTGroup: Record "GST Group";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SIH2.Reset;
//         SIH2.SetCurrentkey("Sell-to Customer No.");
//         SIH2.SetFilter("Sell-to Customer No.", '<>%1', '');
//         SIH2.SetFilter("Location Code", LocCode);
//         SIH2.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             SIH2.SetFilter("No.", VarDoctNo);
//         if SIH2.FindFirst then
//             repeat
//                 CurrKeyValues := SIH2."Sell-to Customer No.";
//                 if PrevKeyValues <> CurrKeyValues then begin
//                     Cust.Get(SIH2."Sell-to Customer No.");
//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Cust."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Cust.Name
//                         else
//                             MasterName := Cust."No." + '-' + Cust.Name;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', 'Sundry Debtors');
//                     AddExportString('ISBILLWISEON', 'YES');
//                     AddExportString('BILLCREDITPERIOD', Cust."Payment Terms Code");
//                     AddExportString('MAILINGNAME', Cust.Name);
//                     if Cust.Address <> '' then begin
//                         XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                         AddExportString('ADDRESS', Cust.Address);
//                         AddExportString('ADDRESS', Cust."Address 2");
//                         XMLValues := XMLValues + '</ADDRESS.LIST>';
//                     end;
//                     AddExportString('LEDSTATENAME', GETTallyStateName(Cust."State Code"));
//                     AddExportString('PINCODE', Cust."Post Code");
//                     AddExportString('COUNTRYNAME', GETTallyCountryName(Cust."Country/Region Code"));
//                     AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(Cust."Country/Region Code"));
//                     AddExportString('LEDGERCONTACT', Cust.Contact);
//                     AddExportString('LEDGERPHONE', Cust."Phone No.");
//                     AddExportString('LEDGERFAX', Cust."Fax No.");
//                     AddExportString('LEDGERMOBILE', Cust."Phone No.");
//                     AddExportString('EMAIL', Cust."E-Mail");
//                     AddExportString('EMAILCC', Cust."E-Mail");
//                     AddExportString('WEBSITE', Cust."Home Page");
//                     AddExportString('INCOMETAXNUMBER', Cust."P.A.N. No.");
//                     AddExportString('GSTREGISTRATIONTYPE', Format(Cust."GST Customer Type"));
//                     AddExportString('PARTYGSTIN', Cust."GST Registration No.");
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := SIH2."Sell-to Customer No.";
//             until SIH2.Next = 0;


//         PrevKeyValues := 'GSTGROUPCODE';
//         CurrKeyValues := '';
//         SIL.Reset;
//         SIL.SetCurrentkey("GST Group Code");
//         if VarDoctNo <> '' then
//             SIL.SetFilter("Document No.", VarDoctNo);
//         //SIL.SETFILTER("GST Group Code",'<>%1','');
//         SIL.SetFilter("Location Code", LocCode);
//         SIL.SetRange("Posting Date", StartDate, EndDate);
//         SIL.SetFilter("No.", '<>%1', '');
//         if SIL.FindFirst then
//             repeat
//                 CurrKeyValues := Format(SIL."GST Group Code");
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     if GSTGroup.Get(SIL."GST Group Code") then
//                         SalesAcctName := 'Sales @ ' + Format(ROUND(GSTGroup."Tax Rate", 0.1)) + '%'
//                     else
//                         SalesAcctName := 'Sales @ 0%';

//                     XMLValues := XMLValues + '<LEDGER NAME="' + SalesAcctName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', SalesAcctName);
//                     AddExportString('PARENT', 'Sales Accounts');
//                     AddExportString('GSTAPPLICABLE', 'Applicable');
//                     AddExportString('TAXTYPE', 'Others');
//                     AddExportString('GSTTYPEOFSUPPLY', 'Goods');
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := Format(SIL."GST Group Code");
//             until SIL.Next = 0;


//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SIL.Reset;
//         SIL.SetCurrentkey("No.");
//         if VarDoctNo <> '' then
//             SIL.SetFilter("Document No.", VarDoctNo);
//         SIL.SetFilter("Location Code", LocCode);
//         SIL.SetRange("Posting Date", StartDate, EndDate);
//         SIL.SetFilter("No.", '<>%1', '');
//         SIL.SetFilter(Type, '<>%1', SIL.Type::Item);
//         if SIL.FindFirst then
//             repeat
//                 CurrKeyValues := SIL."No.";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     MasterName := '';
//                     VarCode := '';
//                     VarName := '';

//                     if SIL.Type = SIL.Type::"G/L Account" then begin
//                         if GLAcct.Get(SIL."No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                     end;

//                     if SIL.Type = SIL.Type::"Charge (Item)" then begin
//                         if CHItem.Get(SIL."No.") then;
//                         VarCode := CHItem."No.";
//                         VarName := CHItem.Description;
//                     end;

//                     if SIL.Type = SIL.Type::"Fixed Asset" then begin
//                         if FARec.Get(SIL."No.") then;
//                         VarCode := FARec."No.";
//                         VarName := FARec.Description;
//                     end;

//                     if SIL.Type = SIL.Type::Resource then begin
//                         if ResRec.Get(SIL."No.") then;
//                         VarCode := ResRec."No.";
//                         VarName := ResRec.Name;
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', 'Indirect Expenses');
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := SIL."No.";
//             until SIL.Next = 0;


//         CurrKeyValues := 'IGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Integrated Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'CGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Central Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'SGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'State Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'CESS';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Cess');
//         AddExportString('CESSVALUATIONMETHOD', 'Any');

//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'OTHER';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Indirect Expenses');
//         XMLValues := XMLValues + '</LEDGER>';
//     end;

//     local procedure CreateSalesCrMemoLedgerXml()
//     var
//         SCH2: Record "Sales Cr.Memo Header";
//         SCL: Record "Sales Cr.Memo Line";
//         Cust: Record Customer;
//         GSTGroup: Record "GST Group";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SCH2.Reset;
//         SCH2.SetCurrentkey("Sell-to Customer No.");
//         SCH2.SetFilter("Location Code", LocCode);
//         SCH2.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             SCH2.SetFilter("No.", VarDoctNo);
//         if SCH2.FindFirst then
//             repeat
//                 CurrKeyValues := SCH2."Sell-to Customer No.";
//                 if PrevKeyValues <> CurrKeyValues then begin
//                     Cust.Get(SCH2."Sell-to Customer No.");
//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Cust."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Cust.Name
//                         else
//                             MasterName := Cust."No." + '-' + Cust.Name;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', 'Sundry Creditors');
//                     AddExportString('ISBILLWISEON', 'YES');
//                     AddExportString('BILLCREDITPERIOD', Cust."Payment Terms Code");
//                     AddExportString('MAILINGNAME', Cust.Name);
//                     if Cust.Address <> '' then begin
//                         XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                         AddExportString('ADDRESS', Cust.Address);
//                         AddExportString('ADDRESS', Cust."Address 2");
//                         XMLValues := XMLValues + '</ADDRESS.LIST>';
//                     end;
//                     AddExportString('LEDSTATENAME', GETTallyStateName(Cust."State Code"));
//                     AddExportString('PINCODE', Cust."Post Code");
//                     AddExportString('COUNTRYNAME', GETTallyCountryName(Cust."Country/Region Code"));
//                     AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(Cust."Country/Region Code"));
//                     AddExportString('LEDGERCONTACT', Cust.Contact);
//                     AddExportString('LEDGERPHONE', Cust."Phone No.");
//                     AddExportString('LEDGERFAX', Cust."Fax No.");
//                     AddExportString('LEDGERMOBILE', Cust."Phone No.");
//                     AddExportString('EMAIL', Cust."E-Mail");
//                     AddExportString('EMAILCC', Cust."E-Mail");
//                     AddExportString('WEBSITE', Cust."Home Page");
//                     AddExportString('INCOMETAXNUMBER', Cust."P.A.N. No.");
//                     AddExportString('GSTREGISTRATIONTYPE', Format(Cust."GST Customer Type"));
//                     AddExportString('PARTYGSTIN', Cust."GST Registration No.");
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := SCH2."Sell-to Customer No.";
//             until SCH2.Next = 0;


//         PrevKeyValues := 'GST Group Code';
//         CurrKeyValues := '';
//         SCL.Reset;
//         SCL.SetCurrentkey("GST Group Code");
//         if VarDoctNo <> '' then
//             SCL.SetFilter("Document No.", VarDoctNo);
//         SCL.SetFilter("Location Code", LocCode);
//         SCL.SetRange("Posting Date", StartDate, EndDate);
//         SCL.SetFilter("No.", '<>%1', '');
//         if SCL.FindFirst then
//             repeat
//                 CurrKeyValues := Format(SCL."GST Group Code");
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     if GSTGroup.Get(SCL."GST Group Code") then
//                         SalesAcctName := 'Sales @ ' + Format(ROUND(GSTGroup."Tax Rate", 0.1)) + '%'
//                     else
//                         SalesAcctName := 'Sales @ 0%';

//                     XMLValues := XMLValues + '<LEDGER NAME="' + SalesAcctName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', SalesAcctName);
//                     AddExportString('PARENT', 'Purchase Accounts');
//                     AddExportString('GSTAPPLICABLE', 'Applicable');
//                     AddExportString('TAXTYPE', 'Others');
//                     AddExportString('GSTTYPEOFSUPPLY', 'Goods');
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := Format(SCL."GST Group Code");
//             until SCL.Next = 0;


//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SCL.Reset;
//         SCL.SetCurrentkey("GST %");
//         if VarDoctNo <> '' then
//             SCL.SetFilter("Document No.", VarDoctNo);
//         SCL.SetFilter("Location Code", LocCode);
//         SCL.SetRange("Posting Date", StartDate, EndDate);
//         SCL.SetFilter("No.", '<>%1', '');
//         SCL.SetFilter(Type, '<>%1', SCL.Type::Item);
//         if SCL.FindFirst then
//             repeat
//                 CurrKeyValues := SCL."No.";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     MasterName := '';
//                     VarCode := '';
//                     VarName := '';

//                     if SCL.Type = SCL.Type::"G/L Account" then begin
//                         if GLAcct.Get(SCL."No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                     end;

//                     if SCL.Type = SCL.Type::"Charge (Item)" then begin
//                         if CHItem.Get(SCL."No.") then;
//                         VarCode := CHItem."No.";
//                         VarName := CHItem.Description;
//                     end;

//                     if SCL.Type = SCL.Type::"Fixed Asset" then begin
//                         if FARec.Get(SCL."No.") then;
//                         VarCode := FARec."No.";
//                         VarName := FARec.Description;
//                     end;

//                     if SCL.Type = SCL.Type::Resource then begin
//                         if ResRec.Get(SCL."No.") then;
//                         VarCode := ResRec."No.";
//                         VarName := ResRec.Name;
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', 'Indirect Expenses');
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := SCL."No.";
//             until SCL.Next = 0;


//         CurrKeyValues := 'IGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Integrated Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'CGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Central Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'SGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'State Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'CESS';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Cess');
//         AddExportString('CESSVALUATIONMETHOD', 'Any');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'OTHER';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Indirect Expenses');
//         XMLValues := XMLValues + '</LEDGER>';
//     end;

//     local procedure CreatePurchaseInvoiceLedgerXml()
//     var
//         PIH2: Record "Purch. Inv. Header";
//         PIL: Record "Purch. Inv. Line";
//         Vend: Record Vendor;
//         GSTGroup: Record "GST Group";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PIH2.Reset;
//         PIH2.SetCurrentkey("Buy-from Vendor No.");
//         PIH2.SetFilter("Location Code", LocCode);
//         PIH2.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             PIH2.SetFilter("No.", VarDoctNo);
//         if PIH2.FindFirst then
//             repeat
//                 CurrKeyValues := PIH2."Buy-from Vendor No.";
//                 if PrevKeyValues <> CurrKeyValues then begin
//                     Vend.Get(PIH2."Buy-from Vendor No.");
//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Vend."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Vend.Name
//                         else
//                             MasterName := Vend."No." + '-' + Vend.Name;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', 'Sundry Creditors');
//                     AddExportString('ISBILLWISEON', 'YES');
//                     AddExportString('BILLCREDITPERIOD', Vend."Payment Terms Code");
//                     AddExportString('MAILINGNAME', Vend.Name);
//                     if Vend.Address <> '' then begin
//                         XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                         AddExportString('ADDRESS', Vend.Address);
//                         AddExportString('ADDRESS', Vend."Address 2");
//                         XMLValues := XMLValues + '</ADDRESS.LIST>';
//                     end;
//                     AddExportString('LEDSTATENAME', GETTallyStateName(Vend."State Code"));
//                     AddExportString('PINCODE', Vend."Post Code");
//                     AddExportString('COUNTRYNAME', GETTallyCountryName(Vend."Country/Region Code"));
//                     AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(Vend."Country/Region Code"));
//                     AddExportString('LEDGERCONTACT', Vend.Contact);
//                     AddExportString('LEDGERPHONE', Vend."Phone No.");
//                     AddExportString('LEDGERFAX', Vend."Fax No.");
//                     AddExportString('LEDGERMOBILE', Vend."Phone No.");
//                     AddExportString('EMAIL', Vend."E-Mail");
//                     AddExportString('EMAILCC', Vend."E-Mail");
//                     AddExportString('WEBSITE', Vend."Home Page");
//                     AddExportString('INCOMETAXNUMBER', Vend."P.A.N. No.");
//                     AddExportString('GSTREGISTRATIONTYPE', Format(Vend."GST Vendor Type"));
//                     AddExportString('PARTYGSTIN', Vend."GST Registration No.");
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := PIH2."Buy-from Vendor No.";
//             until PIH2.Next = 0;


//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PIL.Reset;
//         PIL.SetCurrentkey("GST Group Code");
//         if VarDoctNo <> '' then
//             PIL.SetFilter("Document No.", VarDoctNo);
//         PIL.SetFilter("Location Code", LocCode);
//         PIL.SetRange("Posting Date", StartDate, EndDate);
//         PIL.SetFilter("No.", '<>%1', '');
//         if PIL.FindFirst then
//             repeat
//                 CurrKeyValues := Format(PIL."GST Group Code");
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     if GSTGroup.Get(PIL."GST Group Code") then
//                         SalesAcctName := 'Purchase @ ' + Format(ROUND(GSTGroup."Tax Rate", 0.1)) + '%'
//                     else
//                         SalesAcctName := 'Purchase @ 0%';

//                     //SalesAcctName:='Purchase @ '+FORMAT(ROUND(PIL."GST %",0.1))+'%';
//                     XMLValues := XMLValues + '<LEDGER NAME="' + SalesAcctName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', SalesAcctName);
//                     AddExportString('PARENT', 'Purchase Accounts');
//                     AddExportString('GSTAPPLICABLE', 'Applicable');
//                     AddExportString('TAXTYPE', 'Others');
//                     AddExportString('GSTTYPEOFSUPPLY', 'Goods');
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := Format(PIL."GST Group Code");
//             until PIL.Next = 0;


//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PIL.Reset;
//         PIL.SetCurrentkey("GST %");
//         if VarDoctNo <> '' then
//             PIL.SetFilter("Document No.", VarDoctNo);
//         PIL.SetFilter("Location Code", LocCode);
//         PIL.SetRange("Posting Date", StartDate, EndDate);
//         PIL.SetFilter("No.", '<>%1', '');
//         PIL.SetFilter(Type, '<>%1', PIL.Type::Item);
//         if PIL.FindFirst then
//             repeat
//                 CurrKeyValues := PIL."No.";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     MasterName := '';
//                     VarCode := '';
//                     VarName := '';

//                     if PIL.Type = PIL.Type::"G/L Account" then begin
//                         if GLAcct.Get(PIL."No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                     end;

//                     if PIL.Type = PIL.Type::"Charge (Item)" then begin
//                         if CHItem.Get(PIL."No.") then;
//                         VarCode := CHItem."No.";
//                         VarName := CHItem.Description;
//                     end;

//                     if PIL.Type = PIL.Type::"Fixed Asset" then begin
//                         if FARec.Get(PIL."No.") then;
//                         VarCode := FARec."No.";
//                         VarName := FARec.Description;
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', 'Indirect Expenses');
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := PIL."No.";
//             until PIL.Next = 0;


//         CurrKeyValues := 'IGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Integrated Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'CGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Central Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'SGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'State Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'CESS';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Cess');
//         AddExportString('CESSVALUATIONMETHOD', 'Any');

//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'OTHER';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Indirect Expenses');
//         XMLValues := XMLValues + '</LEDGER>';
//     end;

//     local procedure CreatePurchaseCrMemoLedgerXml()
//     var
//         PCH2: Record "Purch. Cr. Memo Hdr.";
//         PCL: Record "Purch. Cr. Memo Line";
//         Vend: Record Vendor;
//         GSTGroup: Record "GST Group";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PCH2.Reset;
//         PCH2.SetCurrentkey("Buy-from Vendor No.");
//         PCH2.SetFilter("Location Code", LocCode);
//         PCH2.SetRange("Posting Date", StartDate, EndDate);
//         if VarDoctNo <> '' then
//             PCH2.SetFilter("No.", VarDoctNo);
//         if PCH2.FindFirst then
//             repeat
//                 CurrKeyValues := PCH2."Buy-from Vendor No.";
//                 if PrevKeyValues <> CurrKeyValues then begin
//                     Vend.Get(PCH2."Buy-from Vendor No.");
//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Vend."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Vend.Name
//                         else
//                             MasterName := Vend."No." + '-' + Vend.Name;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', 'Sundry Creditors');
//                     AddExportString('ISBILLWISEON', 'YES');
//                     AddExportString('BILLCREDITPERIOD', Vend."Payment Terms Code");
//                     AddExportString('MAILINGNAME', Vend.Name);
//                     if Vend.Address <> '' then begin
//                         XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                         AddExportString('ADDRESS', Vend.Address);
//                         AddExportString('ADDRESS', Vend."Address 2");
//                         XMLValues := XMLValues + '</ADDRESS.LIST>';
//                     end;
//                     AddExportString('LEDSTATENAME', GETTallyStateName(Vend."State Code"));
//                     AddExportString('PINCODE', Vend."Post Code");
//                     AddExportString('COUNTRYNAME', GETTallyCountryName(Vend."Country/Region Code"));
//                     AddExportString('COUNTRYOFRESIDENCE', GETTallyCountryName(Vend."Country/Region Code"));
//                     AddExportString('LEDGERCONTACT', Vend.Contact);
//                     AddExportString('LEDGERPHONE', Vend."Phone No.");
//                     AddExportString('LEDGERFAX', Vend."Fax No.");
//                     AddExportString('LEDGERMOBILE', Vend."Phone No.");
//                     AddExportString('EMAIL', Vend."E-Mail");
//                     AddExportString('EMAILCC', Vend."E-Mail");
//                     AddExportString('WEBSITE', Vend."Home Page");
//                     AddExportString('INCOMETAXNUMBER', Vend."P.A.N. No.");
//                     AddExportString('GSTREGISTRATIONTYPE', Format(Vend."GST Vendor Type"));
//                     AddExportString('PARTYGSTIN', Vend."GST Registration No.");
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := PCH2."Buy-from Vendor No.";
//             until PCH2.Next = 0;


//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PCL.Reset;
//         PCL.SetCurrentkey("GST Group Code");
//         if VarDoctNo <> '' then
//             PCL.SetFilter("Document No.", VarDoctNo);
//         PCL.SetFilter("Location Code", LocCode);
//         PCL.SetRange("Posting Date", StartDate, EndDate);
//         PCL.SetFilter("No.", '<>%1', '');
//         if PCL.FindFirst then
//             repeat
//                 CurrKeyValues := Format(PCL."GST Group Code");
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     if GSTGroup.Get(PCL."GST Group Code") then
//                         SalesAcctName := 'Purchase @ ' + Format(ROUND(GSTGroup."Tax Rate", 0.1)) + '%'
//                     else
//                         SalesAcctName := 'Purchase @ 0%';

//                     //SalesAcctName:='Purchase @ '+FORMAT(ROUND(PCL."GST %",0.1))+'%';
//                     XMLValues := XMLValues + '<LEDGER NAME="' + SalesAcctName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', SalesAcctName);
//                     AddExportString('PARENT', 'Purchase Accounts');
//                     AddExportString('GSTAPPLICABLE', 'Applicable');
//                     AddExportString('TAXTYPE', 'Others');
//                     AddExportString('GSTTYPEOFSUPPLY', 'Goods');
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := Format(PCL."GST Group Code");
//             until PCL.Next = 0;


//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PCL.Reset;
//         PCL.SetCurrentkey("GST %");
//         if VarDoctNo <> '' then
//             PCL.SetFilter("Document No.", VarDoctNo);
//         PCL.SetFilter("Location Code", LocCode);
//         PCL.SetRange("Posting Date", StartDate, EndDate);
//         PCL.SetFilter("No.", '<>%1', '');
//         PCL.SetFilter(Type, '<>%1', PCL.Type::Item);
//         if PCL.FindFirst then
//             repeat
//                 CurrKeyValues := PCL."No.";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     MasterName := '';
//                     VarCode := '';
//                     VarName := '';

//                     if PCL.Type = PCL.Type::"G/L Account" then begin
//                         if GLAcct.Get(PCL."No.") then;
//                         VarCode := GLAcct."No.";
//                         VarName := GLAcct.Name;
//                     end;

//                     if PCL.Type = PCL.Type::"Charge (Item)" then begin
//                         if CHItem.Get(PCL."No.") then;
//                         VarCode := CHItem."No.";
//                         VarName := CHItem.Description;
//                     end;

//                     if PCL.Type = PCL.Type::"Fixed Asset" then begin
//                         if FARec.Get(PCL."No.") then;
//                         VarCode := FARec."No.";
//                         VarName := FARec.Description;
//                     end;

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := VarCode
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := VarName
//                         else
//                             MasterName := VarCode + '-' + VarName;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<LEDGER NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     AddExportString('PARENT', 'Indirect Expenses');
//                     XMLValues := XMLValues + '</LEDGER>';
//                 end;
//                 PrevKeyValues := PCL."No.";
//             until PCL.Next = 0;


//         CurrKeyValues := 'IGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Integrated Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'CGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Central Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'SGST';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'State Tax');
//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'CESS';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Duties & Taxes');
//         AddExportString('TAXTYPE', 'GST');
//         AddExportString('GSTDUTYHEAD', 'Cess');
//         AddExportString('CESSVALUATIONMETHOD', 'Any');

//         XMLValues := XMLValues + '</LEDGER>';

//         CurrKeyValues := 'OTHER';
//         XMLValues := XMLValues + '<LEDGER NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//         AddExportString('NAME', CurrKeyValues);
//         AddExportString('PARENT', 'Indirect Expenses');
//         XMLValues := XMLValues + '</LEDGER>';
//     end;

//     local procedure CreateSalesInvoiceStockGroupXml()
//     var
//         SIL: Record "Sales Invoice Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SIL.Reset;
//         SIL.SetCurrentkey("Product Group Code");
//         if VarDoctNo <> '' then
//             SIL.SetFilter("Document No.", VarDoctNo);
//         SIL.SetFilter("Location Code", LocCode);
//         SIL.SetRange("Posting Date", StartDate, EndDate);
//         SIL.SetFilter("No.", '<>%1', '');
//         SIL.SetFilter("Product Group Code", '<>%1', '');
//         if SIL.FindFirst then
//             repeat
//                 CurrKeyValues := SIL."Product Group Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     ProdGroup.Reset;
//                     ProdGroup.SetRange(Code, CurrKeyValues);
//                     ProdGroup.FindFirst;

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := ProdGroup.Code
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := ProdGroup.Description
//                         else
//                             MasterName := ProdGroup.Code + '-' + ProdGroup.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<STOCKGROUP NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     XMLValues := XMLValues + '</STOCKGROUP>';
//                 end;
//                 PrevKeyValues := SIL."Product Group Code";
//             until SIL.Next = 0;
//     end;

//     local procedure CreateSalesCrMemoStockGroupXml()
//     var
//         SCL: Record "Sales Cr.Memo Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SCL.Reset;
//         SCL.SetCurrentkey("Product Group Code");
//         if VarDoctNo <> '' then
//             SCL.SetFilter("Document No.", VarDoctNo);
//         SCL.SetFilter("Location Code", LocCode);
//         SCL.SetRange("Posting Date", StartDate, EndDate);
//         SCL.SetFilter("No.", '<>%1', '');
//         SCL.SetFilter("Product Group Code", '<>%1', '');
//         if SCL.FindFirst then
//             repeat
//                 CurrKeyValues := SCL."Product Group Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     ProdGroup.Reset;
//                     ProdGroup.SetRange(Code, CurrKeyValues);
//                     ProdGroup.FindFirst;

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := ProdGroup.Code
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := ProdGroup.Description
//                         else
//                             MasterName := ProdGroup.Code + '-' + ProdGroup.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<STOCKGROUP NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     XMLValues := XMLValues + '</STOCKGROUP>';
//                 end;
//                 PrevKeyValues := SCL."Product Group Code";
//             until SCL.Next = 0;
//     end;

//     local procedure CreatePurchaseInvoiceStockGroupXml()
//     var
//         PIL: Record "Purch. Inv. Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PIL.Reset;
//         PIL.SetCurrentkey("Product Group Code");
//         if VarDoctNo <> '' then
//             PIL.SetFilter("Document No.", VarDoctNo);
//         PIL.SetFilter("Location Code", LocCode);
//         PIL.SetRange("Posting Date", StartDate, EndDate);
//         PIL.SetFilter("No.", '<>%1', '');
//         PIL.SetFilter("Product Group Code", '<>%1', '');
//         if PIL.FindFirst then
//             repeat
//                 CurrKeyValues := PIL."Product Group Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     ProdGroup.Reset;
//                     ProdGroup.SetRange(Code, CurrKeyValues);
//                     ProdGroup.FindFirst;

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := ProdGroup.Code
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := ProdGroup.Description
//                         else
//                             MasterName := ProdGroup.Code + '-' + ProdGroup.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<STOCKGROUP NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     XMLValues := XMLValues + '</STOCKGROUP>';
//                 end;
//                 PrevKeyValues := PIL."Product Group Code";
//             until PIL.Next = 0;
//     end;

//     local procedure CreatePurchaseCrMemoStockGroupXml()
//     var
//         PCL: Record "Purch. Cr. Memo Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PCL.Reset;
//         PCL.SetCurrentkey("Product Group Code");
//         if VarDoctNo <> '' then
//             PCL.SetFilter("Document No.", VarDoctNo);
//         PCL.SetFilter("Location Code", LocCode);
//         PCL.SetRange("Posting Date", StartDate, EndDate);
//         PCL.SetFilter("No.", '<>%1', '');
//         PCL.SetFilter("Product Group Code", '<>%1', '');
//         if PCL.FindFirst then
//             repeat
//                 CurrKeyValues := PCL."Product Group Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     ProdGroup.Reset;
//                     ProdGroup.SetRange(Code, CurrKeyValues);
//                     ProdGroup.FindFirst;

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := ProdGroup.Code
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := ProdGroup.Description
//                         else
//                             MasterName := ProdGroup.Code + '-' + ProdGroup.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<STOCKGROUP NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     XMLValues := XMLValues + '</STOCKGROUP>';
//                 end;
//                 PrevKeyValues := PCL."Product Group Code";
//             until PCL.Next = 0;
//     end;

//     local procedure CreateSalesInvoiceStockCategoryXml()
//     var
//         SIL: Record "Sales Invoice Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SIL.Reset;
//         SIL.SetCurrentkey("Item Category Code");
//         if VarDoctNo <> '' then
//             SIL.SetFilter("Document No.", VarDoctNo);
//         SIL.SetFilter("Location Code", LocCode);
//         SIL.SetRange("Posting Date", StartDate, EndDate);
//         SIL.SetFilter("No.", '<>%1', '');
//         SIL.SetFilter("Item Category Code", '<>%1', '');
//         if SIL.FindFirst then
//             repeat
//                 CurrKeyValues := SIL."Item Category Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     ProdCat.Reset;
//                     ProdCat.SetRange(Code, CurrKeyValues);
//                     ProdCat.FindFirst;

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := ProdCat.Code
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := ProdCat.Description
//                         else
//                             MasterName := ProdCat.Code + '-' + ProdCat.Description;

//                     MasterName := ConvertMasterName(MasterName);
//                     XMLValues := XMLValues + '<STOCKCATEGORY NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     AddExportString('ASORIGINAL', 'Yes');
//                     XMLValues := XMLValues + '</STOCKCATEGORY>';
//                 end;
//                 PrevKeyValues := SIL."Item Category Code";
//             until SIL.Next = 0;
//     end;

//     local procedure CreateSalesCrMemoStockCategoryXml()
//     var
//         SCL: Record "Sales Cr.Memo Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SCL.Reset;
//         SCL.SetCurrentkey("Item Category Code");
//         if VarDoctNo <> '' then
//             SCL.SetFilter("Document No.", VarDoctNo);
//         SCL.SetFilter("Location Code", LocCode);
//         SCL.SetRange("Posting Date", StartDate, EndDate);
//         SCL.SetFilter("No.", '<>%1', '');
//         SCL.SetFilter("Item Category Code", '<>%1', '');
//         if SCL.FindFirst then
//             repeat
//                 CurrKeyValues := SCL."Item Category Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     ProdCat.Reset;
//                     ProdCat.SetRange(Code, CurrKeyValues);
//                     ProdCat.FindFirst;

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := ProdCat.Code
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := ProdCat.Description
//                         else
//                             MasterName := ProdCat.Code + '-' + ProdCat.Description;

//                     MasterName := ConvertMasterName(MasterName);
//                     XMLValues := XMLValues + '<STOCKCATEGORY NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     AddExportString('ASORIGINAL', 'Yes');
//                     XMLValues := XMLValues + '</STOCKCATEGORY>';
//                 end;
//                 PrevKeyValues := SCL."Item Category Code";
//             until SCL.Next = 0;
//     end;

//     local procedure CreatePurchaseInvoiceStockCategoryXml()
//     var
//         PIL: Record "Purch. Inv. Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PIL.Reset;
//         PIL.SetCurrentkey("Item Category Code");
//         if VarDoctNo <> '' then
//             PIL.SetFilter("Document No.", VarDoctNo);
//         PIL.SetFilter("Location Code", LocCode);
//         PIL.SetRange("Posting Date", StartDate, EndDate);
//         PIL.SetFilter("No.", '<>%1', '');
//         PIL.SetFilter("Item Category Code", '<>%1', '');
//         if PIL.FindFirst then
//             repeat
//                 CurrKeyValues := PIL."Item Category Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     ProdCat.Reset;
//                     ProdCat.SetRange(Code, CurrKeyValues);
//                     ProdCat.FindFirst;

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := ProdCat.Code
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := ProdCat.Description
//                         else
//                             MasterName := ProdCat.Code + '-' + ProdCat.Description;

//                     MasterName := ConvertMasterName(MasterName);
//                     XMLValues := XMLValues + '<STOCKCATEGORY NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     AddExportString('ASORIGINAL', 'Yes');
//                     XMLValues := XMLValues + '</STOCKCATEGORY>';
//                 end;
//                 PrevKeyValues := PIL."Item Category Code";
//             until PIL.Next = 0;
//     end;

//     local procedure CreatePurchaseCrMemoStockCategoryXml()
//     var
//         PCL: Record "Purch. Cr. Memo Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PCL.Reset;
//         PCL.SetCurrentkey("Item Category Code");
//         if VarDoctNo <> '' then
//             PCL.SetFilter("Document No.", VarDoctNo);
//         PCL.SetFilter("Location Code", LocCode);
//         PCL.SetRange("Posting Date", StartDate, EndDate);
//         PCL.SetFilter("No.", '<>%1', '');
//         PCL.SetFilter("Item Category Code", '<>%1', '');
//         if PCL.FindFirst then
//             repeat
//                 CurrKeyValues := PCL."Item Category Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     ProdCat.Reset;
//                     ProdCat.SetRange(Code, CurrKeyValues);
//                     ProdCat.FindFirst;

//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := ProdCat.Code
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := ProdCat.Description
//                         else
//                             MasterName := ProdCat.Code + '-' + ProdCat.Description;

//                     MasterName := ConvertMasterName(MasterName);
//                     XMLValues := XMLValues + '<STOCKCATEGORY NAME="' + MasterName + '" RESERVEDNAME="">';
//                     AddExportString('NAME', MasterName);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     AddExportString('ASORIGINAL', 'Yes');
//                     XMLValues := XMLValues + '</STOCKCATEGORY>';
//                 end;
//                 PrevKeyValues := PCL."Item Category Code";
//             until PCL.Next = 0;
//     end;

//     local procedure CreateSalesInvoiceStockUnitXml()
//     var
//         SIL: Record "Sales Invoice Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SIL.Reset;
//         SIL.SetCurrentkey("Unit of Measure Code");
//         if VarDoctNo <> '' then
//             SIL.SetFilter("Document No.", VarDoctNo);
//         SIL.SetFilter("Location Code", LocCode);
//         SIL.SetRange("Posting Date", StartDate, EndDate);
//         SIL.SetFilter("No.", '<>%1', '');
//         SIL.SetFilter("Unit of Measure Code", '<>%1', '');
//         if SIL.FindFirst then
//             repeat
//                 CurrKeyValues := SIL."Unit of Measure Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     XMLValues := XMLValues + '<UNIT NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//                     AddExportString('NAME', CurrKeyValues);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('ISSIMPLEUNIT', 'Yes');
//                     XMLValues := XMLValues + '</UNIT>';
//                 end;
//                 PrevKeyValues := SIL."Unit of Measure Code";
//             until SIL.Next = 0;
//     end;

//     local procedure CreateSalesCrMemoStockUnitXml()
//     var
//         SCL: Record "Sales Cr.Memo Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SCL.Reset;
//         SCL.SetCurrentkey("Unit of Measure Code");
//         if VarDoctNo <> '' then
//             SCL.SetFilter("Document No.", VarDoctNo);
//         SCL.SetFilter("Location Code", LocCode);
//         SCL.SetRange("Posting Date", StartDate, EndDate);
//         SCL.SetFilter("No.", '<>%1', '');
//         SCL.SetFilter("Unit of Measure Code", '<>%1', '');
//         if SCL.FindFirst then
//             repeat
//                 CurrKeyValues := SCL."Unit of Measure Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     XMLValues := XMLValues + '<UNIT NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//                     AddExportString('NAME', CurrKeyValues);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('ISSIMPLEUNIT', 'Yes');
//                     XMLValues := XMLValues + '</UNIT>';
//                 end;
//                 PrevKeyValues := SCL."Unit of Measure Code";
//             until SCL.Next = 0;
//     end;

//     local procedure CreatePurchaseInvoiceStockUnitXml()
//     var
//         PIL: Record "Purch. Inv. Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PIL.Reset;
//         PIL.SetCurrentkey("Unit of Measure Code");
//         if VarDoctNo <> '' then
//             PIL.SetFilter("Document No.", VarDoctNo);
//         PIL.SetFilter("Location Code", LocCode);
//         PIL.SetRange("Posting Date", StartDate, EndDate);
//         PIL.SetFilter("No.", '<>%1', '');
//         PIL.SetFilter("Unit of Measure Code", '<>%1', '');
//         if PIL.FindFirst then
//             repeat
//                 CurrKeyValues := PIL."Unit of Measure Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     XMLValues := XMLValues + '<UNIT NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//                     AddExportString('NAME', CurrKeyValues);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('ISSIMPLEUNIT', 'Yes');
//                     XMLValues := XMLValues + '</UNIT>';
//                 end;
//                 PrevKeyValues := PIL."Unit of Measure Code";
//             until PIL.Next = 0;
//     end;

//     local procedure CreatePurchaseCrMemoStockUnitXml()
//     var
//         PCL: Record "Purch. Cr. Memo Line";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PCL.Reset;
//         PCL.SetCurrentkey("Unit of Measure Code");
//         if VarDoctNo <> '' then
//             PCL.SetFilter("Document No.", VarDoctNo);
//         PCL.SetFilter("Location Code", LocCode);
//         PCL.SetRange("Posting Date", StartDate, EndDate);
//         PCL.SetFilter("No.", '<>%1', '');
//         PCL.SetFilter("Unit of Measure Code", '<>%1', '');
//         if PCL.FindFirst then
//             repeat
//                 CurrKeyValues := PCL."Unit of Measure Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     XMLValues := XMLValues + '<UNIT NAME="' + CurrKeyValues + '" RESERVEDNAME="">';
//                     AddExportString('NAME', CurrKeyValues);
//                     //AddExportString('PARENT','Indirect Expenses');
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('ISSIMPLEUNIT', 'Yes');
//                     XMLValues := XMLValues + '</UNIT>';
//                 end;
//                 PrevKeyValues := PCL."Unit of Measure Code";
//             until PCL.Next = 0;
//     end;

//     local procedure CreateSalesInvoiceStockItemXml()
//     var
//         SIL: Record "Sales Invoice Line";
//     begin

//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SIL.Reset;
//         SIL.SetCurrentkey("No.");
//         //IF VarDoctNo<>'' THEN
//         //SIL.SETFILTER("Document No.",VarDoctNo);
//         SIL.SetFilter("Location Code", LocCode);
//         SIL.SetRange("Posting Date", StartDate, EndDate);
//         //SIL.SETFILTER("No.",'<>%1','');
//         SIL.SetRange(Type, SIL.Type::Item);
//         if SIL.FindFirst then
//             repeat
//                 CurrKeyValues := SIL."No.";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     Item.Get(CurrKeyValues);
//                     //MESSAGE(SIL."No.");
//                     MasterName := '';

//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Item."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Item.Description
//                         else
//                             MasterName := Item."No." + '-' + Item.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<STOCKITEM NAME="' + MasterName + '" RESERVEDNAME="">';
//                     //XMLValues:=XMLValues+'<LANGUAGENAME.LIST>';
//                     //XMLValues:=XMLValues+'<NAME.LIST TYPE="String">';
//                     AddExportString('NAME', MasterName);
//                     //XMLValues:=XMLValues+'</NAME.LIST>';
//                     //XMLValues:=XMLValues+'<LANGUAGEID> 1033</LANGUAGEID>';
//                     //XMLValues:=XMLValues+'</LANGUAGENAME.LIST>';

//                     if SIL."Product Group Code" <> '' then
//                         AddExportString('PARENT', GETFullStockGroupName(SIL."Product Group Code"));
//                     if SIL."Item Category Code" <> '' then
//                         AddExportString('CATEGORY', GETFullStockCategoryName(SIL."Item Category Code"));
//                     AddExportString('DESCRIPTION', SIL.Description);
//                     AddExportString('NARRATION', SIL."Description 2");
//                     AddExportString('GSTTYPEOFSUPPLY', Format(SIL."GST Group Type"));
//                     AddExportString('COSTINGMETHOD', 'FIFO');
//                     AddExportString('VALUATIONMETHOD', 'Avg. Price');

//                     AddExportString('BASEUNITS', SIL."Unit of Measure Code");
//                     //<ISBATCHWISEON>No</ISBATCHWISEON>
//                     //<DENOMINATOR> 1</DENOMINATOR>
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('GSTAPPLICABLE', 'Applicable');

//                     //Item.GET(SIL."No.");
//                     /*
//                     GSTSetup.RESET;
//                     GSTSetup.SETRANGE("GST State Code",SIL.State);
//                     GSTSetup.SETRANGE("GST Group Code",SIL."GST Group Code");
//                     GSTSetup.SETRANGE("GST Component",'IGST');
//                     IF GSTSetup.FINDFIRST THEN REPEAT
//                       AddExportValues('<GSTDETAILS.LIST>');
//                       AddExportString('APPLICABLEFROM',ConvertTallyDate(GSTSetup."Effective Date"));
//                       AddExportString('CALCULATIONTYPE','On Value');
//                       AddExportString('CALCULATIONTYPE','On Value');
//                       AddExportString('HSNCODE',SIL."HSN/SAC Code");
//                       IF HSNRec.GET(SIL."GST Group Code",SIL."HSN/SAC Code") THEN ;
//                       AddExportString('HSN',HSNRec.Description);
//                       AddExportString('TAXABILITY','Taxable');
//                       AddExportString('ISREVERSECHARGEAPPLICABLE','No');
//                       AddExportString('ISNONGSTGOODS','No');
//                       AddExportString('GSTINELIGIBLEITC','No');

//                       AddExportValues('<STATEWISEDETAILS.LIST>');
//                       AddExportString('STATENAME','Any');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Central Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"/2));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','State Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"/2));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Integrated Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Cess');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(0));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('</STATEWISEDETAILS.LIST>');
//                       AddExportValues('</GSTDETAILS.LIST>');
//                     UNTIL GSTSetup.NEXT=0;
//                     */


//                     AddExportValues('</STOCKITEM>');

//                 end;
//                 PrevKeyValues := SIL."No.";
//             until SIL.Next = 0;

//     end;

//     local procedure CreateSalesCrMemoStockItemXml()
//     var
//         SCL: Record "Sales Cr.Memo Line";
//     begin

//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SCL.Reset;
//         SCL.SetCurrentkey("No.");
//         if VarDoctNo <> '' then
//             SCL.SetFilter("Document No.", VarDoctNo);
//         SCL.SetFilter("Location Code", LocCode);
//         SCL.SetRange("Posting Date", StartDate, EndDate);
//         SCL.SetFilter("No.", '<>%1', '');
//         SCL.SetRange(Type, SCL.Type::Item);
//         if SCL.FindFirst then
//             repeat
//                 CurrKeyValues := SCL."No.";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     if Item.Get(CurrKeyValues) then;
//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Item."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Item.Description
//                         else
//                             MasterName := Item."No." + '-' + Item.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<STOCKITEM NAME="' + MasterName + '" RESERVEDNAME="">';
//                     //XMLValues:=XMLValues+'<LANGUAGENAME.LIST>';
//                     //XMLValues:=XMLValues+'<NAME.LIST TYPE="String">';
//                     AddExportString('NAME', MasterName);
//                     //XMLValues:=XMLValues+'</NAME.LIST>';
//                     //XMLValues:=XMLValues+'<LANGUAGEID> 1033</LANGUAGEID>';
//                     //XMLValues:=XMLValues+'</LANGUAGENAME.LIST>';

//                     AddExportString('PARENT', GETFullStockGroupName(SCL."Product Group Code"));
//                     AddExportString('CATEGORY', GETFullStockCategoryName(SCL."Item Category Code"));
//                     AddExportString('DESCRIPTION', SCL.Description);
//                     AddExportString('NARRATION', SCL."Description 2");
//                     AddExportString('GSTTYPEOFSUPPLY', Format(SCL."GST Group Type"));
//                     AddExportString('COSTINGMETHOD', 'FIFO');
//                     AddExportString('VALUATIONMETHOD', 'Avg. Price');

//                     AddExportString('BASEUNITS', SCL."Unit of Measure Code");
//                     //<ISBATCHWISEON>No</ISBATCHWISEON>
//                     //<DENOMINATOR> 1</DENOMINATOR>
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('GSTAPPLICABLE', 'Applicable');
//                     /*
//                     Item.GET(SCL."No.");
//                     GSTSetup.RESET;
//                     GSTSetup.SETRANGE("GST State Code",SCL.State);
//                     GSTSetup.SETRANGE("GST Group Code",SCL."GST Group Code");
//                     GSTSetup.SETRANGE("GST Component",'IGST');
//                     IF GSTSetup.FINDFIRST THEN REPEAT
//                       AddExportValues('<GSTDETAILS.LIST>');
//                       AddExportString('APPLICABLEFROM',ConvertTallyDate(GSTSetup."Effective Date"));
//                       AddExportString('CALCULATIONTYPE','On Value');
//                       AddExportString('CALCULATIONTYPE','On Value');
//                       AddExportString('HSNCODE',SIL."HSN/SAC Code");
//                       IF HSNRec.GET(SIL."GST Group Code",SIL."HSN/SAC Code") THEN ;
//                       AddExportString('HSN',HSNRec.Description);
//                       AddExportString('TAXABILITY','Taxable');
//                       AddExportString('ISREVERSECHARGEAPPLICABLE','No');
//                       AddExportString('ISNONGSTGOODS','No');
//                       AddExportString('GSTINELIGIBLEITC','No');

//                       AddExportValues('<STATEWISEDETAILS.LIST>');
//                       AddExportString('STATENAME','Any');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Central Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"/2));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','State Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"/2));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Integrated Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Cess');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(0));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('</STATEWISEDETAILS.LIST>');
//                       AddExportValues('</GSTDETAILS.LIST>');
//                     UNTIL GSTSetup.NEXT=0;
//                     */

//                     AddExportValues('</STOCKITEM>');

//                 end;
//                 PrevKeyValues := SCL."No.";
//             until SCL.Next = 0;

//     end;

//     local procedure CreatePurchaseInvoiceStockItemXml()
//     var
//         PIL: Record "Purch. Inv. Line";
//     begin

//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PIL.Reset;
//         PIL.SetCurrentkey("No.");
//         if VarDoctNo <> '' then
//             PIL.SetFilter("Document No.", VarDoctNo);
//         PIL.SetFilter("Location Code", LocCode);
//         PIL.SetRange("Posting Date", StartDate, EndDate);
//         PIL.SetFilter("No.", '<>%1', '');
//         PIL.SetRange(Type, PIL.Type::Item);
//         if PIL.FindFirst then
//             repeat
//                 CurrKeyValues := PIL."No.";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     if Item.Get(CurrKeyValues) then;
//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Item."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Item.Description
//                         else
//                             MasterName := Item."No." + '-' + Item.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<STOCKITEM NAME="' + MasterName + '" RESERVEDNAME="">';
//                     //XMLValues:=XMLValues+'<LANGUAGENAME.LIST>';
//                     //XMLValues:=XMLValues+'<NAME.LIST TYPE="String">';
//                     AddExportString('NAME', MasterName);
//                     //XMLValues:=XMLValues+'</NAME.LIST>';
//                     //XMLValues:=XMLValues+'<LANGUAGEID> 1033</LANGUAGEID>';
//                     //XMLValues:=XMLValues+'</LANGUAGENAME.LIST>';
//                     if PIL."Product Group Code" <> '' then
//                         AddExportString('PARENT', GETFullStockGroupName(PIL."Product Group Code"));
//                     if PIL."Item Category Code" <> '' then
//                         AddExportString('CATEGORY', GETFullStockCategoryName(PIL."Item Category Code"));
//                     AddExportString('DESCRIPTION', PIL.Description);
//                     AddExportString('NARRATION', PIL."Description 2");
//                     AddExportString('GSTTYPEOFSUPPLY', Format(PIL."GST Group Type"));
//                     AddExportString('COSTINGMETHOD', 'FIFO');
//                     AddExportString('VALUATIONMETHOD', 'Avg. Price');

//                     AddExportString('BASEUNITS', PIL."Unit of Measure Code");
//                     //<ISBATCHWISEON>No</ISBATCHWISEON>
//                     //<DENOMINATOR> 1</DENOMINATOR>
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('GSTAPPLICABLE', 'Applicable');
//                     /*
//                     Item.GET(PIL."No.");
//                     GSTSetup.RESET;
//                     GSTSetup.SETRANGE("GST State Code",PIL.State);
//                     GSTSetup.SETRANGE("GST Group Code",PIL."GST Group Code");
//                     GSTSetup.SETRANGE("GST Component",'IGST');
//                     IF GSTSetup.FINDFIRST THEN REPEAT
//                       AddExportValues('<GSTDETAILS.LIST>');
//                       AddExportString('APPLICABLEFROM',ConvertTallyDate(GSTSetup."Effective Date"));
//                       AddExportString('CALCULATIONTYPE','On Value');
//                       AddExportString('CALCULATIONTYPE','On Value');
//                       AddExportString('HSNCODE',SIL."HSN/SAC Code");
//                       IF HSNRec.GET(SIL."GST Group Code",SIL."HSN/SAC Code") THEN ;
//                       AddExportString('HSN',HSNRec.Description);
//                       AddExportString('TAXABILITY','Taxable');
//                       AddExportString('ISREVERSECHARGEAPPLICABLE','No');
//                       AddExportString('ISNONGSTGOODS','No');
//                       AddExportString('GSTINELIGIBLEITC','No');

//                       AddExportValues('<STATEWISEDETAILS.LIST>');
//                       AddExportString('STATENAME','Any');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Central Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"/2));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','State Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"/2));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Integrated Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Cess');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(0));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('</STATEWISEDETAILS.LIST>');
//                       AddExportValues('</GSTDETAILS.LIST>');
//                     UNTIL GSTSetup.NEXT=0;
//                     */

//                     AddExportValues('</STOCKITEM>');

//                 end;
//                 PrevKeyValues := PIL."No.";
//             until PIL.Next = 0;

//     end;

//     local procedure CreatePurchaseCrMemoStockItemXml()
//     var
//         PCL: Record "Purch. Cr. Memo Line";
//     begin

//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PCL.Reset;
//         PCL.SetCurrentkey("No.");
//         if VarDoctNo <> '' then
//             PCL.SetFilter("Document No.", VarDoctNo);
//         PCL.SetFilter("Location Code", LocCode);
//         PCL.SetRange("Posting Date", StartDate, EndDate);
//         PCL.SetFilter("No.", '<>%1', '');
//         PCL.SetRange(Type, PCL.Type::Item);
//         if PCL.FindFirst then
//             repeat
//                 CurrKeyValues := PCL."No.";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     if Item.Get(CurrKeyValues) then;
//                     MasterName := '';
//                     if MasterNaming = Masternaming::Code then
//                         MasterName := Item."No."
//                     else
//                         if MasterNaming = Masternaming::Name then
//                             MasterName := Item.Description
//                         else
//                             MasterName := Item."No." + '-' + Item.Description;

//                     MasterName := ConvertMasterName(MasterName);

//                     XMLValues := XMLValues + '<STOCKITEM NAME="' + MasterName + '" RESERVEDNAME="">';
//                     //XMLValues:=XMLValues+'<LANGUAGENAME.LIST>';
//                     //XMLValues:=XMLValues+'<NAME.LIST TYPE="String">';
//                     AddExportString('NAME', MasterName);
//                     //XMLValues:=XMLValues+'</NAME.LIST>';
//                     //XMLValues:=XMLValues+'<LANGUAGEID> 1033</LANGUAGEID>';
//                     //XMLValues:=XMLValues+'</LANGUAGENAME.LIST>';

//                     AddExportString('PARENT', GETFullStockGroupName(PCL."Product Group Code"));
//                     AddExportString('CATEGORY', GETFullStockCategoryName(PCL."Item Category Code"));
//                     AddExportString('DESCRIPTION', PCL.Description);
//                     AddExportString('NARRATION', PCL."Description 2");
//                     AddExportString('GSTTYPEOFSUPPLY', Format(PCL."GST Group Type"));
//                     AddExportString('COSTINGMETHOD', 'FIFO');
//                     AddExportString('VALUATIONMETHOD', 'Avg. Price');

//                     AddExportString('BASEUNITS', PCL."Unit of Measure Code");
//                     //<ISBATCHWISEON>No</ISBATCHWISEON>
//                     //<DENOMINATOR> 1</DENOMINATOR>
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('GSTAPPLICABLE', 'Applicable');
//                     /*
//                     Item.GET(PIL."No.");
//                     GSTSetup.RESET;
//                     GSTSetup.SETRANGE("GST State Code",PIL.State);
//                     GSTSetup.SETRANGE("GST Group Code",PIL."GST Group Code");
//                     GSTSetup.SETRANGE("GST Component",'IGST');
//                     IF GSTSetup.FINDFIRST THEN REPEAT
//                       AddExportValues('<GSTDETAILS.LIST>');
//                       AddExportString('APPLICABLEFROM',ConvertTallyDate(GSTSetup."Effective Date"));
//                       AddExportString('CALCULATIONTYPE','On Value');
//                       AddExportString('CALCULATIONTYPE','On Value');
//                       AddExportString('HSNCODE',SIL."HSN/SAC Code");
//                       IF HSNRec.GET(SIL."GST Group Code",SIL."HSN/SAC Code") THEN ;
//                       AddExportString('HSN',HSNRec.Description);
//                       AddExportString('TAXABILITY','Taxable');
//                       AddExportString('ISREVERSECHARGEAPPLICABLE','No');
//                       AddExportString('ISNONGSTGOODS','No');
//                       AddExportString('GSTINELIGIBLEITC','No');

//                       AddExportValues('<STATEWISEDETAILS.LIST>');
//                       AddExportString('STATENAME','Any');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Central Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"/2));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','State Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"/2));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Integrated Tax');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(GSTSetup."GST Component %"));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('<RATEDETAILS.LIST>');
//                       AddExportString('GSTRATEDUTYHEAD','Cess');
//                       AddExportString('GSTRATEVALUATIONTYPE','Based on Value');
//                       AddExportString('GSTRATE',FORMAT(0));
//                       AddExportValues('</RATEDETAILS.LIST>');

//                       AddExportValues('</STATEWISEDETAILS.LIST>');
//                       AddExportValues('</GSTDETAILS.LIST>');
//                     UNTIL GSTSetup.NEXT=0;
//                     */

//                     AddExportValues('</STOCKITEM>');

//                 end;
//                 PrevKeyValues := PCL."No.";
//             until PCL.Next = 0;

//     end;

//     local procedure CreateSalesInvoiceGodownXml()
//     var
//         SIH: Record "Sales Invoice Header";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SIH.Reset;
//         SIH.SetCurrentkey("Location Code");
//         if VarDoctNo <> '' then
//             SIH.SetFilter("No.", VarDoctNo);
//         SIH.SetFilter("Location Code", LocCode);
//         SIH.SetRange("Posting Date", StartDate, EndDate);
//         if SIH.FindFirst then
//             repeat
//                 CurrKeyValues := SIH."Location Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     LocRec.Get(CurrKeyValues);
//                     XMLValues := XMLValues + '<GODOWN NAME="' + LocRec."Tally Godown Name" + '" RESERVEDNAME="">';
//                     AddExportString('NAME', LocRec."Tally Godown Name");
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('HASNOSPACE', 'No');
//                     AddExportString('HASNOSTOCK', 'No');
//                     AddExportString('ISEXTERNAL', 'No');
//                     AddExportString('ISINTERNAL', 'No');
//                     if LocRec.Address <> '' then begin
//                         XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                         AddExportString('ADDRESS', LocRec.Address);
//                         AddExportString('ADDRESS', LocRec."Address 2");
//                         AddExportString('ADDRESS', LocRec."Post Code" + LocRec."State Code");
//                         XMLValues := XMLValues + '</ADDRESS.LIST>';
//                     end;
//                     XMLValues := XMLValues + '</GODOWN>';
//                 end;
//                 PrevKeyValues := SIH."Location Code";
//             until SIH.Next = 0;
//     end;

//     local procedure CreateSalesCrMemoGodownXml()
//     var
//         SCH: Record "Sales Cr.Memo Header";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         SCH.Reset;
//         SCH.SetCurrentkey("Location Code");
//         if VarDoctNo <> '' then
//             SCH.SetFilter("No.", VarDoctNo);
//         SCH.SetFilter("Location Code", LocCode);
//         SCH.SetRange("Posting Date", StartDate, EndDate);
//         if SCH.FindFirst then
//             repeat
//                 CurrKeyValues := SCH."Location Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     LocRec.Get(CurrKeyValues);
//                     XMLValues := XMLValues + '<GODOWN NAME="' + LocRec."Tally Godown Name" + '" RESERVEDNAME="">';
//                     AddExportString('NAME', LocRec."Tally Godown Name");
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('HASNOSPACE', 'No');
//                     AddExportString('HASNOSTOCK', 'No');
//                     AddExportString('ISEXTERNAL', 'No');
//                     AddExportString('ISINTERNAL', 'No');
//                     if LocRec.Address <> '' then begin
//                         XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                         AddExportString('ADDRESS', LocRec.Address);
//                         AddExportString('ADDRESS', LocRec."Address 2");
//                         AddExportString('ADDRESS', LocRec."Post Code" + LocRec."State Code");
//                         XMLValues := XMLValues + '</ADDRESS.LIST>';
//                     end;
//                     XMLValues := XMLValues + '</GODOWN>';
//                 end;
//                 PrevKeyValues := SCH."Location Code";
//             until SCH.Next = 0;
//     end;

//     local procedure CreatePurchaseInvoiceGodownXml()
//     var
//         PIH: Record "Purch. Inv. Header";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PIH.Reset;
//         PIH.SetCurrentkey("Location Code");
//         if VarDoctNo <> '' then
//             PIH.SetFilter("No.", VarDoctNo);
//         PIH.SetFilter("Location Code", LocCode);
//         PIH.SetRange("Posting Date", StartDate, EndDate);
//         if PIH.FindFirst then
//             repeat
//                 CurrKeyValues := PIH."Location Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     LocRec.Get(CurrKeyValues);
//                     XMLValues := XMLValues + '<GODOWN NAME="' + LocRec."Tally Godown Name" + '" RESERVEDNAME="">';
//                     AddExportString('NAME', LocRec."Tally Godown Name");
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('HASNOSPACE', 'No');
//                     AddExportString('HASNOSTOCK', 'No');
//                     AddExportString('ISEXTERNAL', 'No');
//                     AddExportString('ISINTERNAL', 'No');
//                     if LocRec.Address <> '' then begin
//                         XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                         AddExportString('ADDRESS', LocRec.Address);
//                         AddExportString('ADDRESS', LocRec."Address 2");
//                         AddExportString('ADDRESS', LocRec."Post Code" + LocRec."State Code");
//                         XMLValues := XMLValues + '</ADDRESS.LIST>';
//                     end;
//                     XMLValues := XMLValues + '</GODOWN>';
//                 end;
//                 PrevKeyValues := PIH."Location Code";
//             until PIH.Next = 0;
//     end;

//     local procedure CreatePurchaseCrMemoGodownXml()
//     var
//         PCH: Record "Purch. Cr. Memo Hdr.";
//     begin
//         PrevKeyValues := '';
//         CurrKeyValues := '';
//         PCH.Reset;
//         PCH.SetCurrentkey("Location Code");
//         if VarDoctNo <> '' then
//             PCH.SetFilter("No.", VarDoctNo);
//         PCH.SetFilter("Location Code", LocCode);
//         PCH.SetRange("Posting Date", StartDate, EndDate);
//         if PCH.FindFirst then
//             repeat
//                 CurrKeyValues := PCH."Location Code";
//                 if CurrKeyValues <> PrevKeyValues then begin
//                     LocRec.Get(CurrKeyValues);
//                     XMLValues := XMLValues + '<GODOWN NAME="' + LocRec."Tally Godown Name" + '" RESERVEDNAME="">';
//                     AddExportString('NAME', LocRec."Tally Godown Name");
//                     AddExportString('ASORIGINAL', 'Yes');
//                     AddExportString('HASNOSPACE', 'No');
//                     AddExportString('HASNOSTOCK', 'No');
//                     AddExportString('ISEXTERNAL', 'No');
//                     AddExportString('ISINTERNAL', 'No');
//                     if LocRec.Address <> '' then begin
//                         XMLValues := XMLValues + '<ADDRESS.LIST TYPE="String">';
//                         AddExportString('ADDRESS', LocRec.Address);
//                         AddExportString('ADDRESS', LocRec."Address 2");
//                         AddExportString('ADDRESS', LocRec."Post Code" + LocRec."State Code");
//                         XMLValues := XMLValues + '</ADDRESS.LIST>';
//                     end;
//                     XMLValues := XMLValues + '</GODOWN>';
//                 end;
//                 PrevKeyValues := PCH."Location Code";
//             until PCH.Next = 0;
//     end;

//     local procedure ConvertMasterName(InMstName: Text): Text
//     begin
//         InMstName := ConvertStr(InMstName, '&', 'n');
//         InMstName := ConvertStr(InMstName, '<', ' ');
//         InMstName := ConvertStr(InMstName, '>', ' ');
//         InMstName := ConvertStr(InMstName, '+', ' ');
//         InMstName := ConvertStr(InMstName, '=', ' ');
//         InMstName := ConvertStr(InMstName, '"', ' ');
//         InMstName := ConvertStr(InMstName, '''', ' ');
//         exit(InMstName);
//     end;

//     local procedure GETFullStockGroupName(MstCode: Text): Text
//     begin
//         ProdGroup.Reset;
//         ProdGroup.SetRange(Code, MstCode);
//         ProdGroup.FindFirst;
//         if MasterNaming = Masternaming::Code then
//             MstCode := ProdGroup.Code
//         else
//             if MasterNaming = Masternaming::Name then
//                 MstCode := ProdGroup.Description
//             else
//                 MstCode := ProdGroup.Code + '-' + ProdGroup.Description;

//         MstCode := ConvertMasterName(MstCode);
//         exit(MstCode);
//     end;

//     local procedure GETFullStockCategoryName(MstCode: Text): Text
//     begin
//         ProdCat.Get(MstCode);
//         if MasterNaming = Masternaming::Code then
//             MstCode := ProdCat.Code
//         else
//             if MasterNaming = Masternaming::Name then
//                 MstCode := ProdCat.Description
//             else
//                 MstCode := ProdCat.Code + '-' + ProdCat.Description;

//         MstCode := ConvertMasterName(MstCode);
//         exit(MstCode);
//     end;

//     local procedure GETCurrFactor(CurrFac: Decimal): Decimal
//     begin
//         if CurrFac = 0 then
//             exit(1)
//         else
//             exit(CurrFac);
//     end;
// }

