// /// <summary>
// /// Report PBTPL Sale Invoice Test (ID 50107).
// /// </summary>
// Report 50107 "PBTPL Sale Invoice Test"
// {
//     PreviewMode = PrintLayout;
//     RDLCLayout = './Layouts/PBTPLSaleInvoiceTest.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {
//             column(CompanyName; VarCompany.Name)
//             {
//             }
//             column(CompanyAddress; Loc.Address)
//             {
//             }
//             column(CompanyAddress2; Loc."Address 2")
//             {
//             }
//             column(LocPhoneNo; Loc."Phone No.")
//             {
//             }
//             column(LocFaxNo; Loc."Fax No.")
//             {
//             }
//             column(CompanyPostCode; VarCompany."Post Code")
//             {
//             }
//             column(CompanyCity; VarCompany.City)
//             {
//             }
//             column(CompanyState; VarCompany."State Code")
//             {
//             }
//             column(Picture; VarCompany.Picture)
//             {
//             }
//             column(CompanyGSTNNo; Loc."GST Registration No.")
//             {
//             }
//             column(PAN; VarCompany."P.A.N. No.")
//             {
//             }
//             column(InvoiceType; InvoiceType)
//             {
//             }
//             column(CIN; '')
//             {
//             }
//             column(LRRRDate; "Sales Invoice Header"."LR/RR Date")
//             {
//             }
//             column(LRRRNo; "Sales Invoice Header"."LR/RR No.")
//             {
//             }
//             column(DueDate; "Sales Invoice Header"."Due Date")
//             {
//             }
//             column(ShipmentMethodCode; "Sales Invoice Header"."Shipment Method Code")
//             {
//             }
//             column(SalespersonCode; "Sales Invoice Header"."Salesperson Code")
//             {
//             }
//             column(PostingDate; "Sales Invoice Header"."Posting Date")
//             {
//             }
//             column(OrderNo; "Sales Invoice Header"."Order No.")
//             {
//             }
//             column(DocumentNo; "Sales Invoice Header"."No.")
//             {
//             }
//             column(DocumentDate; "Sales Invoice Header"."Document Date")
//             {
//             }
//             column(PaytoName; "Sales Invoice Header"."Sell-to Customer Name")
//             {
//             }
//             column(PaytoAddress; "Sales Invoice Header"."Sell-to Address")
//             {
//             }
//             column(AmounttoCustomer; AmounttoCustomer)
//             {
//             }
//             column(paytoStateName; paytoStateName)
//             {
//             }
//             column(PaytoState; PaytoState)
//             {
//             }
//             column(PaytoGSTNNo; PaytoGSTNNo)
//             {
//             }
//             column(ShiptoCode; "Sales Invoice Header"."Ship-to Code")
//             {
//             }
//             column(ShiptoName; "Sales Invoice Header"."Ship-to Name")
//             {
//             }
//             column(ShiptoName2; "Sales Invoice Header"."Ship-to Name 2")
//             {
//             }
//             column(ShiptoAddress; "Sales Invoice Header"."Ship-to Address")
//             {
//             }
//             column(ShiptoAddress2; "Sales Invoice Header"."Ship-to Address 2")
//             {
//             }
//             column(ShiptoCity; "Sales Invoice Header"."Ship-to City")
//             {
//             }
//             column(ShiptoContact; "Sales Invoice Header"."Ship-to Contact")
//             {
//             }
//             column(VehicleNo; "Sales Invoice Header"."Vehicle No.")
//             {
//             }
//             column(GRNo; "Sales Invoice Header"."LR/RR No.")
//             {
//             }
//             column(TransportMode; TransportMethod.Description)
//             {
//             }
//             column(BankName; BankName)
//             {
//             }
//             column(RTGSNo; RTGSNo)
//             {
//             }
//             column(AccountNo; AccountNo)
//             {
//             }
//             column(NumberText; Numbertext[1])
//             {
//             }
//             column(ReportName; ReportName)
//             {
//             }
//             dataitem(CopyLoop; Integer)
//             {
//                 DataItemTableView = sorting(Number);
//                 dataitem(PageLoop; Integer)
//                 {
//                     DataItemTableView = sorting(Number) where(Number = const(1));
//                     column(NoOfCopies; CopyText)
//                     {
//                     }
//                     column(OutputNo; OutputNo)
//                     {
//                     }
//                     dataitem("Sales Invoice Line"; "Sales Invoice Line")
//                     {
//                         DataItemLink = "Document No." = field("No.");
//                         DataItemLinkReference = "Sales Invoice Header";
//                         DataItemTableView = sorting("Document No.", "Line No.");
//                         column(SRNo; SRNo)
//                         {
//                         }
//                         column(ItemNo; "Sales Invoice Line"."No.")
//                         {
//                         }
//                         column(Description; "Sales Invoice Line".Description)
//                         {
//                         }
//                         column(Quantity; "Sales Invoice Line".Quantity)
//                         {
//                         }
//                         column(UnitMeasure; "Sales Invoice Line"."Unit of Measure Code")
//                         {
//                             IncludeCaption = true;
//                         }
//                         column(UnitCost; "Sales Invoice Line"."Unit Price")
//                         {
//                         }
//                         column(BaseAmount; "Sales Invoice Line"."Line Amount")
//                         {
//                         }
//                         column(NettAmount; "Sales Invoice Line"."Line Amount" + TotalGSTAmount)
//                         {
//                         }
//                         column(HSNCode; "Sales Invoice Line"."HSN/SAC Code")
//                         {
//                         }
//                         column(GSTRate; ItemGSTRate)
//                         {
//                         }
//                         column(TotalGSTAmount; TotalGSTAmount)//"Sales Invoice Line"."Total GST Amount") //Lk
//                         {
//                         }
//                         column(GSTBaseAmount; GSTBaseAmount) //Lk
//                         {
//                         }
//                         column(ItemGSTRate; ItemGSTRate)
//                         {
//                         }
//                         column(ItemIGSTRate; ItemIGSTRate)
//                         {
//                         }
//                         column(ItemIGSTAmount; ItemIGSTAmount)
//                         {
//                         }
//                         column(ItemCGSTRate; ItemCGSTRate)
//                         {
//                         }
//                         column(ItemCGSTAmount; ItemCGSTAmount)
//                         {
//                         }
//                         column(ItemSGSTRate; ItemSGSTRate)
//                         {
//                         }
//                         column(ItemSGSTAmount; ItemSGSTAmount)
//                         {
//                         }
//                         column(ItemCessRate; ItemCessRate)
//                         {
//                         }
//                         column(ItemCessAmount; ItemCessAmount)
//                         {
//                         }
//                         column(ItemGSTTaxAmt; ItemGSTTaxAmt)
//                         {
//                         }
//                         column(ItemNettAmount; ItemNettAmount)
//                         {
//                         }
//                         trigger OnPreDataItem();
//                         begin
//                             SRNo := 0;
//                         end;

//                         trigger OnAfterGetRecord();
//                         begin
//                             if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account") and ("Sales Invoice Line"."No." = '9140') then
//                                 CurrReport.Skip;
//                             SRNo += 1;
//                             J := 1;
//                             ItemIGSTRate := 0;
//                             ItemIGSTAmount := 0;
//                             ItemCGSTRate := 0;
//                             ItemCGSTAmount := 0;
//                             ItemSGSTRate := 0;
//                             ItemSGSTAmount := 0;
//                             ItemCessRate := 0;
//                             ItemCessAmount := 0;
//                             ItemGSTRate := 0;
//                             ItemGSTTaxAmt := 0;
//                             ItemNettAmount := 0;
//                             GSTBaseAmount := 0;
//                             TotalGSTAmount := 0;
//                             GSTComponent.Reset;
//                             GSTComponent.SetRange("GST Jurisdiction Type", "Sales Invoice Line"."GST Jurisdiction Type");
//                             if GSTComponent.FindSet then
//                                 repeat
//                                     GSTComponentCode[J] := GSTComponent.Code;
//                                     DetailedGSTLedgerEntry.Reset;
//                                     DetailedGSTLedgerEntry.SetCurrentkey("Transaction Type", "Document Type", "Document No.");
//                                     DetailedGSTLedgerEntry.SetFilter("Location Code", "Sales Invoice Header"."Location Code");
//                                     DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."entry type"::"Initial Entry");
//                                     DetailedGSTLedgerEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
//                                     DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."transaction type"::Sales);
//                                     DetailedGSTLedgerEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
//                                     DetailedGSTLedgerEntry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
//                                     DetailedGSTLedgerEntry.SetRange("GST Component Code", GSTComponentCode[J]);
//                                     if DetailedGSTLedgerEntry.FindSet then
//                                         repeat
//                                             ItemGSTTaxAmt := ItemGSTTaxAmt - DetailedGSTLedgerEntry."GST Amount";
//                                             if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
//                                                 ItemIGSTRate := DetailedGSTLedgerEntry."GST %";
//                                                 ItemGSTRate := DetailedGSTLedgerEntry."GST %";
//                                                 ItemIGSTAmount := ItemIGSTAmount - DetailedGSTLedgerEntry."GST Amount";
//                                                 GSTBaseAmount := GSTBaseAmount - DetailedGSTLedgerEntry."GST Base Amount";
//                                             end;
//                                             if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
//                                                 ItemCGSTRate := DetailedGSTLedgerEntry."GST %";
//                                                 ItemGSTRate := DetailedGSTLedgerEntry."GST %" * 2;
//                                                 ItemCGSTAmount := ItemCGSTAmount - DetailedGSTLedgerEntry."GST Amount";
//                                                 GSTBaseAmount := GSTBaseAmount - DetailedGSTLedgerEntry."GST Base Amount";

//                                             end;
//                                             if (DetailedGSTLedgerEntry."GST Component Code" = 'SGST') or (DetailedGSTLedgerEntry."GST Component Code" = 'UTGST') then begin
//                                                 ItemSGSTRate := DetailedGSTLedgerEntry."GST %";
//                                                 ItemSGSTAmount := ItemSGSTAmount - DetailedGSTLedgerEntry."GST Amount";
//                                                 GSTBaseAmount := GSTBaseAmount - DetailedGSTLedgerEntry."GST Base Amount";

//                                             end;
//                                             if DetailedGSTLedgerEntry."GST Component Code" = 'Cess' then begin
//                                                 ItemCessRate := DetailedGSTLedgerEntry."GST %";
//                                                 ItemCessAmount := ItemCessAmount - DetailedGSTLedgerEntry."GST Amount";
//                                             end;
//                                         until DetailedGSTLedgerEntry.Next = 0;
//                                     TotalGSTAmount := ItemIGSTAmount + ItemCGSTAmount + ItemSGSTAmount + ItemCessAmount;
//                                     J += 1;
//                                 until GSTComponent.Next = 0;
//                         end;

//                     }
//                     trigger OnAfterGetRecord();
//                     begin
//                         OutputNo := OutputNo + 1;
//                     end;

//                 }
//                 trigger OnPreDataItem();
//                 begin
//                     NoOfLoops := Abs(NoOfcopies);
//                     SetRange(Number, 1, NoOfLoops);
//                 end;

//                 trigger OnAfterGetRecord();
//                 begin
//                     if CopyLoop.Number = 1 then
//                         CopyText := 'Original'
//                     else
//                         if CopyLoop.Number = 2 then
//                             CopyText := 'Duplicate for Supplier'
//                         else
//                             if CopyLoop.Number = 3 then
//                                 CopyText := 'Triplicate for Transporter'
//                             else
//                                 CopyText := 'Extra Copy';
//                 end;

//             }
//             trigger OnPreDataItem();
//             begin
//                 StartDate := 0D;
//                 EndDate := 0D;
//                 if StartDate <> 0D then
//                     SetRange("Sales Invoice Header"."Posting Date", StartDate, EndDate);
//                 if DocumentNo <> '' then
//                     SetRange("Sales Invoice Header"."No.", DocumentNo);
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 //BlankLines := 0;
//                 VarSaleInvLine.Reset;
//                 VarSaleInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");

//                 //<<<<<<<<<<<<<<<<<<<LK Start>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//                 AmounttoCustomer := 0;

//                 CustLedEntry.Reset();
//                 CustLedEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
//                 CustLedEntry.CalcFields(Amount);
//                 AmounttoCustomer := CustLedEntry.Amount;

//                 TotalGstAmt_ := 0;
//                 DLE.Reset();
//                 DLE.SetRange("Document No.", "Sales Invoice Header"."No.");
//                 DLE.SetRange("Transaction Type", DLE."Transaction Type"::Sales);
//                 DLE.CALCSUMS(DLE."GST Amount");
//                 TotalGstAmt_ := DLE."GST Amount";

//                 //<<<<<<<<<<<<<<<<<<<LK End>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


//                 // VarSaleInvLine.CalcSums("Total GST Amount");
//                 if TotalGstAmt_ <> 0 then
//                     InvoiceType := 'TAX INVOICE'
//                 else
//                     InvoiceType := 'BILL OF SUPPLY';
//                 if Loc.Get("Sales Invoice Header"."Location Code") then
//                     // "Sales Invoice Header".CalcFields("Amount to Customer");
//                 VarPostedVoucher.InitTextVariable;
//                 VarPostedVoucher.FormatNoText(Numbertext, CustLedEntry.Amount, '');
//                 if TransportMethod.Get("Sales Invoice Header"."Transport Method") then;
//                 PaytoState := '';
//                 PaytoGSTNNo := '';
//                 VarCust.Reset;
//                 VarCust.SetRange(VarCust."No.", "Sales Invoice Header"."Sell-to Customer No.");
//                 if VarCust.FindFirst then begin
//                     if StateRec.Get(VarCust."State Code") then
//                         PaytoState := StateRec.Description + '(' + StateRec."State Code (GST Reg. No.)" + ')';
//                     PaytoGSTNNo := VarCust."GST Registration No.";
//                     paytoStateName := StateRec.Description;
//                 end;
//                 ShipToState := '';
//                 ShiptoGSTNNo := '';
//                 VarCust1.Reset;
//                 VarCust1.SetRange(VarCust1."No.", "Sales Invoice Header"."Ship-to Code");
//                 if VarCust1.FindFirst then begin
//                     ShipToState := VarCust1."State Code";
//                     ShiptoGSTNNo := VarCust1."GST Registration No.";
//                 end;
//                 TotalValue := 0;
//                 // CalcFields("Sales Invoice Header"."Amount to Customer");
//                 TotalValue := CustLedEntry.Amount;
//                 //MESSAGE(format(TotalValue));
//                 BankName := '';
//                 AccountNo := '';
//                 RTGSNo := '';
//                 BAnkAct.Get("Sales&Receivbles"."Bank Account for Receivables");
//                 BankName := BAnkAct.Name;
//                 AccountNo := BAnkAct."Bank Account No.";
//                 RTGSNo := BAnkAct."Transit No.";
//                 OutputNo := 0;
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
//                 field("No Of copies"; NoOfcopies)
//                 {
//                     ApplicationArea = Basic;
//                 }

//             }
//         }

//         actions
//         {
//         }
//     }

//     trigger OnInitReport()
//     begin
//         NoOfcopies := 3;


//     end;



//     trigger OnPreReport()
//     begin
//         VarCompany.Get;
//         VarCompany.CalcFields(Picture);
//         ReportName := 'Sale Invoice';
//         "Sales&Receivbles".Get;

//     end;

//     var
//         AmounttoCustomer: decimal;
//         DLE: Record "Detailed GST Ledger Entry";
//         TotalGstAmt_: Decimal;
//         CustLedEntry: Record "Cust. Ledger Entry";
//         TotalGSTAmount: Decimal;
//         VarCompany: Record "Company Information";
//         VarCust: Record Customer;
//         paytoStateName: Text;
//         PaytoState: Text;
//         PaytoGSTNNo: Text;
//         ShipToState: Text;
//         ShiptoGSTNNo: Text;
//         NoOfLoops: Integer;
//         NoOfcopies: Integer;
//         OutputNo: Integer;
//         CopyText: Text;
//         Numbertext: array[1] of Text;
//         MaxNo: Integer;
//         PrintNo: Integer;
//         NeedNo: Integer;
//         TotalAmount: Decimal;
//         ReportName: Text;
//         VarCust1: Record Customer;
//         SRNo: Integer;
//         VarPostedVoucher: Report "Posted Voucher";
//         StartDate: Date;
//         EndDate: Date;
//         DocumentNo: Code[20];
//         VarSaleInvLine: Record "Sales Invoice Line";
//         Blank: Integer;
//         Loc: Record Location;
//         CompanyGSTNNo: Text;
//         TotalValue: Decimal;
//         "Sales&Receivbles": Record "Sales & Receivables Setup";
//         LocAdd: Text;
//         LocAdd2: Text;
//         InvoiceType: Text;
//         TotalGSTAmt: Decimal;
//         TransportMethod: Record "Transport Method";
//         StateRec: Record State;
//         BAnkAct: Record "Bank Account";
//         BankName: Text;
//         AccountNo: Text;
//         RTGSNo: Text;
//         BlankLines: Integer;
//         MaxLine: Integer;
//         VarSaleLine: Record "Sales Invoice Line";
//         GSTBaseAmount: Decimal;
//         GSTComponent: Record "GST Component";
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//         GSTComponentCode: array[5] of Text;
//         J: Integer;
//         ItemGSTRate: Decimal;
//         ItemIGSTRate: Decimal;
//         ItemIGSTAmount: Decimal;
//         ItemCGSTRate: Decimal;
//         ItemCGSTAmount: Decimal;
//         ItemSGSTRate: Decimal;
//         ItemSGSTAmount: Decimal;
//         ItemCessRate: Decimal;
//         ItemCessAmount: Decimal;
//         ItemGSTTaxAmt: Decimal;
//         ItemNettAmount: Decimal;
//         B: Integer;

// }
