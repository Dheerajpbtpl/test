// /// <summary>
// /// Report GST Sales Invoice (ID 50111).
// /// </summary>
// Report 50111 "GST Sales Invoice"
// {
//     Caption = 'Sales - Invoice';
//     UseSystemPrinter = true;
//     PreviewMode = Normal;
//     RDLCLayout = './Layouts/GSTSalesInvoice.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {
//             RequestFilterFields = "No.";
//             RequestFilterHeading = 'Sales Quote';
//             column(No_SalesHeader; "Sales Invoice Header"."No.")
//             {
//             }
//             column(CustStateCodeTitle; CustStateCodeTitle)
//             {
//             }
//             column(CustStateCodeValue; CustStateCodeValue)
//             {
//             }
//             dataitem(CopyLoop; Integer)
//             {
//                 DataItemTableView = sorting(Number);
//                 dataitem(PageLoop; Integer)
//                 {
//                     column(CompanyInfo3Picture; CompanyInfo3.Picture)
//                     {
//                     }
//                     column(Cmp_Name; COMPANYNAME)
//                     {
//                     }
//                     column(CompanyAddr1; locationadd)
//                     {
//                     }
//                     column(CompanyAddr2; locationadd1)
//                     {
//                     }
//                     column(CompanyAddr3; locationadd2)
//                     {
//                     }
//                     column(CompanyAddr4; locationaddCitypost)
//                     {
//                     }
//                     column(CompanyInfoPhoneNo; "locationPhnNo.")
//                     {
//                     }
//                     column(CompanyInfoHomePage; CompanyInfoHomePage)
//                     {
//                     }
//                     column(AddtAxPerc; 'Add Vat @' + Format(AddtAxPerc) + '%')
//                     {
//                     }
//                     column(CompanyInfoEMail; locationEmail)
//                     {
//                     }
//                     column(CompanyInfoVATRegNo; locationTIN)
//                     {
//                     }
//                     column(Show; ShowOverDueAmt)
//                     {
//                     }
//                     column(Bank_Name; BankAcct.Name)
//                     {
//                     }
//                     column(Bank_Ac_No; BankAcct."Bank Account No.")
//                     {
//                     }
//                     column(Bank_Branch; BankAcct."Bank Branch No.")
//                     {
//                     }
//                     column(Bank_Ifsc; BankAcct.Iban)
//                     {
//                     }
//                     column(CustPatnertype; Cust."Partner Type")
//                     {
//                     }
//                     column(OutputNo; OutputNo)
//                     {
//                     }
//                     column(Document_Date; Format("Sales Invoice Header"."Document Date"))
//                     {
//                     }
//                     column(Order_No; "Sales Invoice Header"."Order No.")
//                     {
//                     }
//                     column(Order_Date; Format("Sales Invoice Header"."Order Date"))
//                     {
//                     }
//                     column(Transport_Method; "Sales Invoice Header"."Transport Method")
//                     {
//                     }
//                     column(Lr_No; "Sales Invoice Header"."LR/RR No.")
//                     {
//                     }
//                     column(Lr_Date; Format("Sales Invoice Header"."LR/RR Date"))
//                     {
//                     }
//                     column(Pymt_Terms; "Sales Invoice Header"."Payment Terms Code")
//                     {
//                     }
//                     column(Due_Date; Format("Sales Invoice Header"."Due Date"))
//                     {
//                     }
//                     column(Shipping_Agent; "Sales Invoice Header"."Shipping Agent Code")
//                     {
//                     }
//                     column(Sell_To_Custno; "Sales Invoice Header"."Sell-to Customer No.")
//                     {
//                     }
//                     column(Sell_To_Cust_name; "Sales Invoice Header"."Sell-to Customer Name")
//                     {
//                     }
//                     column(Sell_To_Addr1; "Sales Invoice Header"."Sell-to Address")
//                     {
//                     }
//                     column(Sell_To_Addr2; "Sales Invoice Header"."Sell-to Address 2")
//                     {
//                     }
//                     column(Sell_To_City; "Sales Invoice Header"."Sell-to City")
//                     {
//                     }
//                     column(Sell_To_Contact; "Sales Invoice Header"."Sell-to Contact")
//                     {
//                     }
//                     column(Sell_To_PostCode; "Sales Invoice Header"."Sell-to Post Code")
//                     {
//                     }
//                     column(Sell_To_Country; "Sales Invoice Header"."Sell-to County")
//                     {
//                     }
//                     column(Sell_To_Mobile_No; Cust."Phone No." + ' Email ' + Cust."E-Mail")
//                     {
//                     }
//                     column(Sell_To_Email; Cust."E-Mail")
//                     {
//                     }
//                     column(Ship_To_Name; "Sales Invoice Header"."Ship-to Name")
//                     {
//                     }
//                     column(Ship_To_Address; "Sales Invoice Header"."Ship-to Address")
//                     {
//                     }
//                     column(Ship_To_Address2; "Sales Invoice Header"."Ship-to Address 2")
//                     {
//                     }
//                     column(Ship_To_City; "Sales Invoice Header"."Ship-to City")
//                     {
//                     }
//                     column(Ship_To_Contact; "Sales Invoice Header"."Ship-to Contact")
//                     {
//                     }
//                     column(Ship_To_PostCode; "Sales Invoice Header"."Ship-to Post Code")
//                     {
//                     }
//                     column(Ship_To_Country; "Sales Invoice Header"."Ship-to County")
//                     {
//                     }
//                     column(SellToTinNo; SellToTinNo)
//                     {
//                     }
//                     column(ShipToTin; ShipToTin)
//                     {
//                     }
//                     column(Sales_Person_Code; "Sales Invoice Header"."Salesperson Code")
//                     {
//                     }
//                     column(BillingType; '')
//                     {
//                     }
//                     column(VarBookNo; VarBookNo)
//                     {
//                     }
//                     column(CopyText; CopyText)
//                     {
//                     }
//                     column(RetTaxStr; RetTaxStr)
//                     {
//                     }
//                     column(TexInvAuth; TexInvAuth)
//                     {
//                     }
//                     column(GenInvAuthMgr; GenInvAuthMgr)
//                     {
//                     }
//                     column(GenInvAuth; GenInvAuth)
//                     {
//                     }
//                     column(PreAuthBy; PreAuthBy)
//                     {
//                     }
//                     column(PreIssueSign; PreIssueSign)
//                     {
//                     }
//                     column(TaxInvoiceAuthMgr; TaxInvoiceAuthMgr)
//                     {
//                     }
//                     column(GenInvoiceAuth; GenInvoiceAuth)
//                     {
//                     }
//                     column(AuthSignTitle; AuthSignTitle)
//                     {
//                     }
//                     column(TaxInvoiceAuthDesig; TaxInvoiceAuthDesig)
//                     {
//                     }
//                     column(Terms1; Terms1)
//                     {
//                     }
//                     column(Terms2; Terms2)
//                     {
//                     }
//                     column(Terms3; Terms3)
//                     {
//                     }
//                     column(Terms4; Terms4)
//                     {
//                     }
//                     column(Terms5; Terms5)
//                     {
//                     }
//                     column(Terms6; Terms6)
//                     {
//                     }
//                     column(Terms7; Terms7)
//                     {
//                     }
//                     dataitem("Sales Invoice Line"; "Sales Invoice Line")
//                     {
//                         DataItemLink = "Document No." = field("No.");
//                         DataItemLinkReference = "Sales Invoice Header";
//                         column(CashReceAmt; 0)
//                         {
//                         }
//                         column(LineSrNo; LineSrNo)
//                         {
//                         }
//                         column(SalesLineLineAmount; "Sales Invoice Line"."Line Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(NumberText_1; NumberText[1])
//                         {
//                         }
//                         column(NumberText_2; NumberText[2])
//                         {
//                         }
//                         column(NumberText1_1; NumberText1[1])
//                         {
//                         }
//                         column(NumberText1_2; NumberText1[2])
//                         {
//                         }
//                         column(VendorItemNo; VendItemNo)
//                         {
//                         }
//                         column(ShowWarrAndSupp; ShowWarrAndSupp)
//                         {
//                         }
//                         column(ITEMNO; ITEMNO)
//                         {
//                         }
//                         column(ItemSuptNO; ItemSuptNO)
//                         {
//                         }
//                         column(CustWTY; CustWTY)
//                         {
//                         }
//                         column(ITEMWty; ITEMWty)
//                         {
//                         }
//                         column(Item_Details; ItemDesc)
//                         {
//                         }
//                         column(Description_SalesLine; "Sales Invoice Line".Description)
//                         {
//                         }
//                         column(ItemHSNSACCode; ItemHSNSACCode)
//                         {
//                         }
//                         column(ItemGSTRate; ItemGSTRate)
//                         {
//                         }
//                         column(Quantity_SalesLine; "Sales Invoice Line".Quantity)
//                         {
//                         }
//                         column(UnitOfMeasure_SalesLine; "Sales Invoice Line"."Unit of Measure")
//                         {
//                         }
//                         column(LineAmount_SalesLine; "Sales Invoice Line"."Line Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(UnitPrice_SalesLine; "Sales Invoice Line"."Unit Price")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 2;
//                         }
//                         column(LineDiscount_SalesLine; "Sales Invoice Line"."Line Discount %")
//                         {
//                         }
//                         column(AllowInvDisc_SalesLine; "Sales Invoice Line"."Allow Invoice Disc.")
//                         {
//                         }
//                         column(LineDiscount_SalesLineAmount; "Sales Invoice Line"."Line Discount Amount")
//                         {
//                         }
//                         column(Type_SalesLine; "Sales Invoice Line".Type)
//                         {
//                         }
//                         column(LineNo_SalesLine; "Sales Invoice Line"."Line No.")
//                         {
//                         }
//                         column(SalesLineInvDiscountAmount; "Sales Invoice Line"."Inv. Discount Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VarTotalInwords; VarTotalInwords)
//                         {
//                         }
//                         column(VarSubTotal; VarSubTotal)
//                         {
//                         }
//                         column(VarDiscount; VarDiscount)
//                         {
//                         }
//                         column(OutputFourVatAmt; OutputFourVatAmt)
//                         {
//                         }
//                         column(OuputAddOneAmt; OuputAddOneAmt)
//                         {
//                         }
//                         column(OutputVatTwelveAmt; OutputVatTwelveAmt)
//                         {
//                         }
//                         column(OutputAddVatOneHalfAmt; OutputAddVatOneHalfAmt)
//                         {
//                         }
//                         column(TaxValue; TaxValue)
//                         {
//                         }
//                         column(FreightAmt; FreightAmt)
//                         {
//                         }
//                         column(RoundOffAmt; RoundOffAmt)
//                         {
//                         }
//                         column(TotalInvValue; TotalInvValue)
//                         {
//                         }
//                         column(VarCurrAmt; VarCurrAmt)
//                         {
//                         }
//                         column(VarPrevAmt; VarPrevAmt)
//                         {
//                         }
//                         column(VarSaveInwords; VarSaveInwords)
//                         {
//                         }
//                         column(LocationCode; LocationCode)
//                         {
//                         }
//                         column(Locationcity; Locationcity)
//                         {
//                         }
//                         column(UnitPriceInclofTax_SalesLine; "Sales Invoice Line"."Unit Price Incl. of Tax")
//                         {
//                         }
//                         column(ItemTotQty; ItemTotQty)
//                         {
//                         }
//                         column(ItemWarrSuppNumber; ItemWarrSuppNumber)
//                         {
//                         }
//                         column(ItemLedLotNo; ItemLedLotNo)
//                         {
//                         }
//                         column(ItemLedSrNo; ItemLedSrNo)
//                         {
//                         }
//                         column(CommentDesc; CommentDesc)
//                         {
//                         }
//                         column(LedgerAcct1Name; LedgerAcct1Name)
//                         {
//                         }
//                         column(LedgerAcct2Name; LedgerAcct2Name)
//                         {
//                         }
//                         column(LedgerAcct3Name; LedgerAcct3Name)
//                         {
//                         }
//                         column(LedgerAcct4Name; LedgerAcct4Name)
//                         {
//                         }
//                         column(LedgerAcct5Name; LedgerAcct5Name)
//                         {
//                         }
//                         column(LedgerAcct6Name; LedgerAcct6Name)
//                         {
//                         }
//                         column(LedgerAcct7Name; LedgerAcct7Name)
//                         {
//                         }
//                         column(LedgerAcct8Name; LedgerAcct8Name)
//                         {
//                         }
//                         column(LedgerAcct9Name; LedgerAcct9Name)
//                         {
//                         }
//                         column(LedgerAcct10Name; LedgerAcct10Name)
//                         {
//                         }
//                         column(LedgerAcct1Amt; LedgerAcct1Amt)
//                         {
//                         }
//                         column(LedgerAcct2Amt; LedgerAcct2Amt)
//                         {
//                         }
//                         column(LedgerAcct3Amt; LedgerAcct3Amt)
//                         {
//                         }
//                         column(LedgerAcct4Amt; LedgerAcct4Amt)
//                         {
//                         }
//                         column(LedgerAcct5Amt; LedgerAcct5Amt)
//                         {
//                         }
//                         column(LedgerAcct6Amt; LedgerAcct6Amt)
//                         {
//                         }
//                         column(LedgerAcct7Amt; LedgerAcct7Amt)
//                         {
//                         }
//                         column(LedgerAcct8Amt; LedgerAcct8Amt)
//                         {
//                         }
//                         column(LedgerAcct9Amt; LedgerAcct9Amt)
//                         {
//                         }
//                         column(LedgerAcct10Amt; LedgerAcct10Amt)
//                         {
//                         }
//                         column(GSTBaseAmount1; GSTBaseAmount[1])
//                         {
//                         }
//                         column(GSTBaseAmount2; GSTBaseAmount[2])
//                         {
//                         }
//                         column(GSTBaseAmount3; GSTBaseAmount[3])
//                         {
//                         }
//                         column(GSTBaseAmount4; GSTBaseAmount[4])
//                         {
//                         }
//                         column(ItemGSTAmt1; ItemGSTAmt[1])
//                         {
//                         }
//                         column(ItemGSTAmt2; ItemGSTAmt[2])
//                         {
//                         }
//                         column(ItemGSTAmt3; ItemGSTAmt[3])
//                         {
//                         }
//                         column(ItemGSTAmt4; ItemGSTAmt[4])
//                         {
//                         }
//                         dataitem("Reservation Entry"; "Item Ledger Entry")
//                         {
//                             DataItemTableView = where("Entry No." = const(123));
//                             column(Item_Serial_No; "Reservation Entry"."Serial No.")
//                             {
//                             }
//                             column(Item_Lot_No; "Reservation Entry"."Lot No.")
//                             {
//                             }
//                             column(Item_Lot_Qty; -"Reservation Entry".Quantity)
//                             {
//                             }
//                             trigger OnPreDataItem();
//                             begin
//                                 ResvEntCount := ResvEntCount + 1;
//                                 if ResvEntCount <> 1 then begin
//                                     Clear(ItemGSTAmt);
//                                     Clear(GSTBaseAmount);
//                                 end;
//                                 SalesShipRec.Reset;
//                                 VarShipNo := '';
//                                 SalesShipRec.SetRange(SalesShipRec."Order No.", "Sales Invoice Header"."Order No.");
//                                 if SalesShipRec.FindFirst then
//                                     VarShipNo := SalesShipRec."No.";
//                                 SalesShipLine.Reset;
//                                 VarShipLineNo := 0;
//                                 /*
// 								SalesShipLine.SETRANGE(SalesShipLine."Invoice No","Sales Invoice Header"."No.");
// 								SalesShipLine.SETRANGE(SalesShipLine."Order Line No.","Sales Invoice Line"."Line No.");
// 								IF  SalesShipLine.FINDFIRST THEN
// 									VarShipLineNo:=SalesShipLine."Line No.";
// 								*/
//                                 SetRange("Reservation Entry"."Document No.", VarShipNo);
//                                 SetRange("Reservation Entry"."Document Line No.", VarShipLineNo);

//                             end;

//                         }
//                         trigger OnPreDataItem();
//                         begin
//                             SetRange("Sales Invoice Line".Type, "Sales Invoice Line".Type::Item);
//                             LineSrNo := 0;
//                         end;

//                         trigger OnAfterGetRecord();
//                         begin
//                             ItemTotQty := 0;
//                             LineSrNo += 1;
//                             Clear(ItemGSTAmt);
//                             Clear(GSTBaseAmount);
//                             ItemHSNSACCode := "Sales Invoice Line"."HSN/SAC Code";
//                             // ItemGSTRate := ROUND("Sales Invoice Line"."GST %"); 
//                             SalesInvLineGLAcct.Reset;
//                             SalesInvLineGLAcct.SetRange("Document No.", "Sales Invoice Header"."No.");
//                             SalesInvLineGLAcct.SetRange(Type, SalesInvLineGLAcct.Type::"G/L Account");
//                             SalesInvLineGLAcct.CalcSums(Amount);
//                             if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then
//                                 VarSubTotal := VarSubTotal + "Sales Invoice Line".Amount;
//                             if ItemRec.Get("Sales Invoice Line"."No.") then;
//                             VendItemNo := ItemRec."Vendor Item No.";
//                             ItemDesc := ItemRec."Description 2";
//                             ITEMNO := ItemRec."No.";
//                             //  ITEMWty:=ItemRec."Warranty Days";
//                             //  ItemSuptNO:=ItemRec."Support Center No";
//                             if Evaluate(VarDtNum, ITEMWty) then;
//                             WarrLastDt := "Sales Invoice Header"."Document Date" + VarDtNum;
//                             ItemWarrSuppNumber := 'W.E.D.  ' + Format(WarrLastDt) + ' ' + 'SUPT NO:	' + ItemSuptNO;
//                             ItemTotQty := ItemTotQty + "Sales Invoice Line".Quantity;
//                             SalesShipRec.Reset;
//                             SalesShipRec.SetRange(SalesShipRec."Order No.", "Sales Invoice Header"."Order No.");
//                             if SalesShipRec.FindFirst then
//                                 VarShipNo := SalesShipRec."No.";
//                             /*
// 							SalesShipLine.RESET;
// 							SalesShipLine.SETRANGE(SalesShipLine."Invoice No","Sales Invoice Header"."No.");
// 							SalesShipLine.SETRANGE(SalesShipLine."Order Line No.","Sales Invoice Line"."Line No.");
// 							IF  SalesShipLine.FINDFIRST THEN
// 								VarShipLineNo:=SalesShipLine."Line No.";
// 							*/
//                             ItemLedSrNo := '';
//                             ItemLedLotNo := '';
//                             LotIndex := 0;
//                             SrNoIndex := 0;
//                             ItemLedEntry.Reset;
//                             ItemLedEntry.SetRange(ItemLedEntry."Document No.", VarShipNo);
//                             ItemLedEntry.SetRange(ItemLedEntry."Document Line No.", VarShipLineNo);
//                             if ItemLedEntry.FindFirst then
//                                 repeat
//                                     if ItemLedEntry."Lot No." <> '' then begin
//                                         LotIndex := LotIndex + 1;
//                                         if LotIndex = 1 then
//                                             ItemLedLotNo := ItemLedLotNo + ItemLedEntry."Lot No."
//                                         else
//                                             ItemLedLotNo := ItemLedLotNo + ' , ' + ItemLedEntry."Lot No.";
//                                     end;
//                                     if ItemLedEntry."Serial No." <> '' then begin
//                                         SrNoIndex := SrNoIndex + 1;
//                                         if SrNoIndex = 1 then
//                                             ItemLedSrNo := ItemLedSrNo + ItemLedEntry."Serial No."
//                                         else
//                                             ItemLedSrNo := ItemLedSrNo + ' , ' + ItemLedEntry."Serial No.";
//                                     end;
//                                 until ItemLedEntry.Next = 0;
//                             CustWTY := '';
//                             /*
// 							IF Cust."Partner Type"= Cust."Partner Type":: Customer THEN BEGIN
// 							  CustWTY:= ItemWarrSuppNumber;
// 							  ShowWarrAndSupp:=TRUE;
// 							END;
// 							*/
//                             CommentDesc := '';
//                             SalesCommLine.Reset;
//                             SalesCommLine.SetRange(SalesCommLine."Document Type", SalesCommLine."document type"::Invoice);
//                             SalesCommLine.SetRange(SalesCommLine."No.", "Sales Invoice Line"."Document No.");
//                             SalesCommLine.SetRange(SalesCommLine."Document Line No.", "Sales Invoice Line"."Line No.");
//                             if SalesCommLine.FindFirst then
//                                 repeat
//                                     CommentDesc := CommentDesc + SalesCommLine.Comment + ' , '
//                             until SalesCommLine.Next = 0;
//                             if IsGSTApplicable then begin
//                                 J := 1;
//                                 GSTComponent.Reset;
//                                 GSTComponent.SetRange("GST Jurisdiction Type", "GST Jurisdiction Type");
//                                 if GSTComponent.FindSet then
//                                     repeat
//                                         ItemGSTTemp := 0;
//                                         GSTComponentCode[J] := GSTComponent.Code;
//                                         DetailedGSTLedgerEntry.Reset;
//                                         DetailedGSTLedgerEntry.SetCurrentkey("Transaction Type", "Document Type", "Document No.", "Document Line No.");
//                                         DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."transaction type"::Sales);
//                                         DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
//                                         DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
//                                         DetailedGSTLedgerEntry.SetRange("GST Component Code", GSTComponentCode[J]);
//                                         if DetailedGSTLedgerEntry.FindSet then
//                                             repeat
//                                                 GSTCompAmount[J] += DetailedGSTLedgerEntry."GST Amount";
//                                                 ItemGSTAmt[J] := ItemGSTAmt[J] - DetailedGSTLedgerEntry."GST Amount";
//                                                 GSTBaseAmount[J] := GSTBaseAmount[J] - DetailedGSTLedgerEntry."GST Base Amount";

//                                                 ItemGSTRate := DetailedGSTLedgerEntry."GST %"//Lk
//                                             until DetailedGSTLedgerEntry.Next = 0;
//                                         J += 1;
//                                     until GSTComponent.Next = 0;
//                             end;
//                             /*  StructureLineDetails.Reset;
//                              StructureLineDetails.SetRange(Type, StructureLineDetails.Type::Sale);
//                              StructureLineDetails.SetRange("Document Type", StructureLineDetails."document type"::Invoice);
//                              StructureLineDetails.SetRange("Invoice No.", "Document No.");
//                              StructureLineDetails.SetRange("Item No.", "No.");
//                              StructureLineDetails.SetRange("Line No.", "Line No.");
//                              if StructureLineDetails.Find('-') then
//                                  repeat
//                                      if not StructureLineDetails."Payable to Third Party" then begin
//                                          if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::Charges then
//                                              ChargesAmount := ChargesAmount + Abs(StructureLineDetails.Amount);
//                                          if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::"Other Taxes" then
//                                              OtherTaxesAmount := OtherTaxesAmount + Abs(StructureLineDetails.Amount);
//                                      end;
//                                  until StructureLineDetails.Next = 0; */ //Lk (Structure Table missing )
//                             LedgerAcct1Name := GSTComponentCode[1];
//                             LedgerAcct2Name := GSTComponentCode[2];
//                             LedgerAcct3Name := GSTComponentCode[3];
//                             LedgerAcct4Name := GSTComponentCode[4];
//                             LedgerAcct5Name := GSTComponentCode[5];
//                             LedgerAcct6Name := 'Charges Amount';
//                             LedgerAcct7Name := 'Other Taxes Amount';
//                             LedgerAcct8Name := 'Round Off';
//                             LedgerAcct9Name := 'Freight';
//                             LedgerAcct10Name := 'Round Off';
//                             LedgerAcct1Amt := -GSTCompAmount[1];
//                             LedgerAcct2Amt := -GSTCompAmount[2];
//                             LedgerAcct3Amt := -GSTCompAmount[3];
//                             LedgerAcct4Amt := -GSTCompAmount[4];
//                             LedgerAcct5Amt := -GSTCompAmount[5];
//                             LedgerAcct6Amt := ChargesAmount;
//                             LedgerAcct7Amt := OtherTaxesAmount;
//                             LedgerAcct8Amt := 0;//SalesInvLineGLAcct.Amount;
//                             LedgerAcct9Amt := FreightAmt;
//                             LedgerAcct10Amt := RoundOffAmt;
//                             ResvEntCount := 0;

//                         end;

//                     }
//                     trigger OnPreDataItem();
//                     begin
//                         SetRange(Number, 1, 1);
//                     end;

//                     trigger OnAfterGetRecord();
//                     begin
//                         LedgerAcct1Name := '';
//                         LedgerAcct2Name := '';
//                         LedgerAcct3Name := '';
//                         LedgerAcct4Name := '';
//                         LedgerAcct5Name := '';
//                         LedgerAcct6Name := '';
//                         LedgerAcct7Name := '';
//                         LedgerAcct8Name := '';
//                         LedgerAcct9Name := '';
//                         LedgerAcct10Name := '';
//                         LedgerAcct1Amt := 0;
//                         LedgerAcct2Amt := 0;
//                         LedgerAcct3Amt := 0;
//                         LedgerAcct4Amt := 0;
//                         LedgerAcct5Amt := 0;
//                         LedgerAcct6Amt := 0;
//                         LedgerAcct7Amt := 0;
//                         LedgerAcct8Amt := 0;
//                         LedgerAcct9Amt := 0;
//                         LedgerAcct10Amt := 0;
//                         VarSubTotal := 0;
//                     end;

//                 }
//                 trigger OnPreDataItem();
//                 begin
//                     if NoOfCopies <= 0 then
//                         NoOfCopies := 1;
//                     SetRange(Number, 1, Abs(NoOfCopies));
//                     OutputNo := 1;
//                 end;

//                 trigger OnAfterGetRecord();
//                 var
//                     SalesPost: Codeunit "Sales-Post";
//                 begin
//                     if Number > 1 then begin
//                         OutputNo += 1;
//                     end;

//                     if Number = 1 then
//                         CopyText := 'Original'
//                     else
//                         if Number = 2 then
//                             CopyText := 'Duplicate'
//                         else
//                             if Number = 3 then
//                                 CopyText := 'Triplicate'
//                             else
//                                 CopyText := 'Extra Copy';
//                 end;

//             }
//             trigger OnAfterGetRecord();
//             var
//                 "Sell-to Country": Text[50];
//             begin
//                 LineSrNo := 0;
//                 VarSaveInwords := 0;
//                 FreightAmt := 0;
//                 RoundOffAmt := 0;
//                 VarDiscount := 0;
//                 VarSubTotal := 0;
//                 OutputFourVatAmt := 0;
//                 OuputAddOneAmt := 0;
//                 OutputVatTwelveAmt := 0;
//                 OutputAddVatOneHalfAmt := 0;
//                 TotalInvValue := 0;
//                 VarTotalInwords := '';
//                 LineDISAMT := 0;
//                 ItemTotQty := 0;
//                 CashRcptAmt := 0;
//                 if "Sales Invoice Header"."Posting Date" >= Dmy2date(1, 7, 2017) then
//                     IsGSTApplicable := true;
//                 /*
// 				SalesInvHdr.RESET;
// 				SalesInvHdr.SETRANGE(SalesInvHdr."No.","Sales Invoice Header"."No.") ;
// 				IF SalesInvHdr.FINDFIRST THEN
// 				CashRcptAmt:=SalesInvHdr."Cash Received Amount";*/
//                 if StateRec.Get("GST Ship-to State Code") then
//                     CustStateCodeValue := StateRec."State Code (GST Reg. No.)"
//                 else
//                     CustStateCodeValue := '';
//                 if location.Get("Sales Invoice Header"."Location Code") then;
//                 locationadd2 := location.Name;
//                 locationadd := location.Address;
//                 locationadd1 := location."Address 2";
//                 locationaddCitypost := location.City + location."Post Code";
//                 locationTIN := location."GST Registration No.";
//                 "locationPhnNo." := location.Contact;
//                 locationEmail := location."E-Mail";
//                 // CurrReport.Language := Language_.GetLanguageID("Language Code");
//                 CompanyInfo.Get;
//                 CompanyInfo3.Get;
//                 CompanyInfo3.CalcFields(CompanyInfo3.Picture);
//                 if RespCenter.Get("Responsibility Center") then begin
//                     CompanyAddr1 := RespCenter.Address;
//                     CompanyAddr2 := RespCenter."Address 2";
//                     CompanyAddr3 := RespCenter.City;
//                     CompanyAddr4 := RespCenter."Post Code";
//                     CompanyInfoPhoneNo := RespCenter."Phone No.";
//                     CompanyInfoHomePage := RespCenter."Fax No.";
//                     CompanyInfoEMail := RespCenter."E-Mail";
//                 end else begin
//                     CompanyAddr1 := CompanyInfo.Address;
//                     CompanyAddr2 := CompanyInfo."Address 2";
//                     CompanyAddr3 := CompanyInfo.City;
//                     CompanyAddr4 := CompanyInfo."Post Code";
//                     CompanyInfoPhoneNo := CompanyInfo."Phone No.";
//                     CompanyInfoHomePage := CompanyInfo."Fax No.";
//                     CompanyInfoEMail := CompanyInfo."E-Mail";
//                 end;
//                 //IF BankAcct.GET("Sales Invoice Header"."Bank Detail") THEN ;
//                 if Cust.Get("Sales Invoice Header"."Sell-to Customer No.") then begin
//                     Cust.CalcFields(Cust.Balance, Cust."Balance Due");
//                     SellToTinNo := Cust."GST Registration No.";
//                     // VarPrevAmt:=Cust."Balance Due";
//                     // VarCurrAmt:=Cust.Balance+TotalInvValue;
//                     VarPrevAmt := Cust.GetTotalAmountLCY;
//                     VarCurrAmt := Cust.CalcOverdueBalance;
//                     RetTaxStr := 'Sales Invoice ( ' + Format("Sales Invoice Header"."Invoice Type") + ' )';
//                 end;
//                 //if ShipToCust.GET("Sales Header"."Ship-to Code") Then
//                 ShipToTin := SellToTinNo;
//                 /*
// 				IF Cust."GST Registration No."<> '' THEN BEGIN
// 				 BooknumRec.RESET;
// 				 BooknumRec.SETRANGE(BooknumRec."Document No","Sales Invoice Header"."Order No.");
// 				 IF BooknumRec.FINDFIRST THEN
// 				   VarBookNo:=BooknumRec."Book No";
// 				END;
// 				*/
//                 SalesLineRec.Reset;
//                 SalesLineRec.SetFilter(SalesLineRec."Document No.", "Sales Invoice Header"."No.");
//                 SalesLineRec.SetRange(SalesLineRec.Type, SalesLineRec.Type::"G/L Account");
//                 if SalesLineRec.FindFirst then
//                     repeat
//                         if SalesLineRec."No." = '8246' then
//                             FreightAmt := FreightAmt + SalesLineRec."Unit Price Incl. of Tax";
//                         if SalesLineRec."No." = '8240' then
//                             RoundOffAmt := RoundOffAmt + SalesLineRec."Unit Price Incl. of Tax";
//                         if SalesLineRec."No." = '8410' then
//                             VarDiscount := VarDiscount + SalesLineRec."Unit Price Incl. of Tax";
//                     until SalesLineRec.Next = 0;
//                 /*
// 				SalesLineRec.RESET;
// 				SalesLineRec.SETFILTER(SalesLineRec."Document No.","Sales Invoice Header"."No.");
// 				IF SalesLineRec.FINDFIRST THEN
// 				REPEAT
// 				  IF SalesLineRec.Type=SalesLineRec.Type::Item THEN
// 						VarSubTotal:=VarSubTotal+SalesLineRec.Amount;
// 				  IF SalesLineRec."Tax %"=4 THEN BEGIN
// 						OutputFourVatAmt:=OutputFourVatAmt+(SalesLineRec."Amount Including Tax"-SalesLineRec."Line Amount")-(SalesLineRec."VAT Base Amount"*1/100);
// 						OuputAddOneAmt:=OuputAddOneAmt+(SalesLineRec."VAT Base Amount"*1/100);
// 				  END;
// 					IF SalesLineRec."Tax %"=5 THEN BEGIN
// 						OutputFourVatAmt:=OutputFourVatAmt+(SalesLineRec."Amount Including Tax"-SalesLineRec."Line Amount")-(SalesLineRec."VAT Base Amount"*1/100);
// 						OuputAddOneAmt:=OuputAddOneAmt+(SalesLineRec."VAT Base Amount"*1/100);
// 				  END;
// 				AddtAxPerc:=0;
// 				IF "Posting Date"<20150509D THEN
// 				AddtAxPerc:=1.5
// 				ELSE
// 				AddtAxPerc:=2;
// 				  IF SalesLineRec."Tax %"=12.5 THEN BEGIN
// 						OutputVatTwelveAmt:=OutputVatTwelveAmt+(SalesLineRec."Amount Including Tax"-SalesLineRec."Line Amount")-(SalesLineRec."VAT Base Amount"*AddtAxPerc/100);
// 						OutputAddVatOneHalfAmt:=OutputAddVatOneHalfAmt+(SalesLineRec."VAT Base Amount"*AddtAxPerc/100);
// 				  END;
// 					IF SalesLineRec."Tax %"=14.5 THEN BEGIN
// 						OutputVatTwelveAmt:=OutputVatTwelveAmt+(SalesLineRec."Amount Including Tax"-SalesLineRec."Line Amount")-(SalesLineRec."VAT Base Amount"*AddtAxPerc/100);
// 						OutputAddVatOneHalfAmt:=OutputAddVatOneHalfAmt+(SalesLineRec."VAT Base Amount"*AddtAxPerc/100);
// 				  END;
// 				   LineDISAMT+=SalesLineRec."Line Discount Amount";
// 				   VarSaveInwords:= LineDISAMT+"Sales Invoice Header"."Credit Note"+VarDiscount;
// 				UNTIL SalesLineRec.NEXT=0;
// 				//TotalInvValue:=VarSubTotal+OutputFourVatAmt+OuputAddOneAmt+ OutputVatTwelveAmt+OutputAddVatOneHalfAmt+VarDiscount+FreightAmt+ RoundOffAmt;
// 				//TotalInvValue:=ROUND(TotalInvValue);
// 				*/

//                 //    AmounttoCust_Total:=0;
//                 //<<<<<<<<<<<<<<<<<<<<<<<LK Start>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.

//                 CustLedEntry.Reset();
//                 CustLedEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
//                 CustLedEntry.CalcFields(Amount);
//                 TotalInvValue := CustLedEntry.amount;
//                 //<<<<<<<<<<<<<<<<<<<<<<<LK End>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.


//                 PostedVchr1.InitTextVariable;
//                 PostedVchr1.FormatNoText(NumberText1, TotalInvValue, "Sales Invoice Header"."Currency Code");
//                 PostedVchr1.InitTextVariable;
//                 PostedVchr1.FormatNoText(NumberText, VarSaveInwords, "Sales Invoice Header"."Currency Code");
//                 /*
// 				IF "Sales Invoice Header"."Location Code"='MG-A'  THEN BEGIN
// 					LocationRec.GET("Sales Invoice Header"."Location Code");
// 				   TaxInvAuthMgr:=LocationRec."Tax Invoice Auth Mgr";
// 				   TexInvAuth:=LocationRec."Tax Invoice Auth";
// 				   GenInvAuth:='Name :'+LocationRec."Gen Invoice Auth";
// 				   GenInvAuthMgr:='Designation :'+LocationRec."Gen Invoice Auth Mgr";
// 				 END;
// 				*/
//                 LocationRec.Reset;
//                 LocationRec.SetRange(LocationRec.Code, "Sales Invoice Header"."Location Code");
//                 if LocationRec.FindFirst then begin
//                     Locationcity := 'SUBJECT TO ' + LocationRec.City + ' JURISDICTION';
//                 end;
//                 PreAuthBy := '';
//                 PreIssueSign := '';
//                 TaxInvoiceAuthMgr := '';
//                 GenInvoiceAuth := '';
//                 AuthSignTitle := '';
//                 if RetTaxStr = 'Tax Invoice' then begin
//                     PreAuthBy := 'Pre Autheticated by';
//                     AuthSignTitle := 'Authorised Signatory';
//                     PreIssueSign := 'Issuing Signatory';
//                     TaxInvoiceAuthMgr := 'Name :' + TaxInvAuthMgr;
//                     TaxInvoiceAuthDesig := 'Designation :' + TexInvAuth;
//                     GenInvoiceAuth := GenInvAuth;
//                 end;
//                 Terms1 := '';
//                 Terms2 := '';
//                 Terms3 := '';
//                 Terms4 := '';
//                 Terms5 := '';
//                 Terms6 := '';
//                 Terms7 := '';
//                 /*
// 				IF LocRec.GET("Sales Invoice Header"."Location Code") THEN BEGIN
// 					Terms1:=LocRec.Terms1;
// 					Terms2:=LocRec.Terms2;
// 					Terms3:=LocRec.Terms3;
// 					Terms4:=LocRec.Terms4;
// 					Terms5:=LocRec.Terms5;
// 					Terms6:=LocRec.Terms6;
// 					Terms7:=LocRec.Terms7;
// 				END;
// 				*/

//             end;

//             trigger OnPostDataItem();
//             var
//                 ToDo: Record "To-do";
//             begin
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
//                 field(NoOfCopies; NoOfCopies)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'NoOfCopies';
//                 }
//                 field(ShowOverDueAmt; ShowOverDueAmt)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'ShowOverDueAmt';
//                 }

//             }
//         }

//         actions
//         {
//         }

//         trigger OnOpenPage()
//         begin
//             NoOfCopies := 1;
//         end;
//     }

//     trigger OnInitReport()
//     begin
//         GLSetup.Get;
//         CompanyInfo.Get;
//         SalesSetup.Get;
//         CompanyInfo3.Get;
//         CompanyInfo3.CalcFields(Picture);

//     end;



//     var
//         CustLedEntry: Record "Cust. Ledger Entry";

//         GLSetup: Record "General Ledger Setup";
//         ShipmentMethod: Record "Shipment Method";
//         PaymentTerms: Record "Payment Terms";
//         SalesPurchPerson: Record "Salesperson/Purchaser";
//         CompanyInfo: Record "Company Information";
//         CompanyInfo3: Record "Company Information";
//         SalesSetup: Record "Sales & Receivables Setup";
//         VATAmountLine: Record "VAT Amount Line" temporary;
//         RespCenter: Record "Responsibility Center";
//         Language_: Record Language;
//         MoreLines: Boolean;
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[30];
//         VALVATAmountLCY: Decimal;
//         OutputNo: Integer;
//         ShowLogo: Boolean;
//         BankAcct: Record "Bank Account";
//         ItemRec: Record Item;
//         ItemDesc: Text;
//         VendItemNo: Code[20];
//         LineSrNo: Integer;
//         CompanyAddr: array[6] of Text[150];
//         FormatAddr: Codeunit "Format Address";
//         VarTotalInwords: Text;
//         VarSubTotal: Decimal;
//         VarDiscount: Decimal;
//         OutputFourVatAmt: Decimal;
//         OuputAddOneAmt: Decimal;
//         OutputVatTwelveAmt: Decimal;
//         OutputAddVatOneHalfAmt: Decimal;
//         FreightAmt: Decimal;
//         RoundOffAmt: Decimal;
//         TotalInvValue: Decimal;
//         VarCurrAmt: Decimal;
//         VarPrevAmt: Decimal;
//         VarSaveInwords: Decimal;
//         Cust: Record Customer;
//         SellToTinNo: Text;
//         ShipToCust: Record "Ship-to Address";
//         ShipToTin: Text;
//         BooknumRec: Record Products;
//         VarBookNo: Integer;
//         CompanyAddr1: Text;
//         CompanyAddr2: Text;
//         CompanyAddr3: Text;
//         CompanyAddr4: Text;
//         CompanyInfoPhoneNo: Text;
//         CompanyInfoHomePage: Text;
//         CompanyInfoEMail: Text;
//         SalesLineRec: Record "Sales Invoice Line";
//         RetTaxStr: Text;
//         SalesInvHdr: Record "Sales Invoice Header";
//         PostedVchr: Report "Posted Voucher";
//         NumberText: array[2] of Text[80];
//         NumberText1: array[2] of Text[80];
//         PostedVchr1: Report "Posted Voucher";
//         ShowOverDueAmt: Boolean;
//         TaxInvAuthMgr: Text;
//         GenInvAuth: Text;
//         TexInvAuth: Text;
//         GenInvAuthMgr: Text;
//         LocationRec: Record Location;
//         SalesShipRec: Record "Sales Shipment Header";
//         VarShipNo: Code[20];
//         SalesShipLine: Record "Sales Shipment Line";
//         VarShipLineNo: Integer;
//         LocationCode: Option;
//         Locationcity: Text;
//         TaxValue: Decimal;
//         ItemTb: Record Item;
//         SalesLineRec1: Record "Sales Invoice Line";
//         ItemHSNSACCode: Text;
//         ItemGSTRate: Decimal;
//         ITEMNO: Text;
//         ITEMWty: Text;
//         ItemSuptNO: Text;
//         NewDate: Date;
//         LineDISAMT: Decimal;
//         PreAuthBy: Text;
//         PreIssueSign: Text;
//         TaxInvoiceAuthMgr: Text;
//         GenInvoiceAuth: Text;
//         ItemTotQty: Integer;
//         ItemWarrSuppNumber: Text;
//         WarrLastDt: Date;
//         VarDtNum: Integer;
//         ItemLedEntry: Record "Item Ledger Entry";
//         ItemLedLotNo: Text;
//         ItemLedSrNo: Text;
//         CustWTY: Text;
//         LotIndex: Integer;
//         SrNoIndex: Integer;
//         LocRec: Record Location;
//         Terms1: Text[250];
//         Terms2: Text[250];
//         Terms3: Text[250];
//         Terms4: Text[250];
//         Terms5: Text[250];
//         Terms6: Text[250];
//         Terms7: Text[250];
//         location: Record Location;
//         locationadd: Text[50];
//         locationadd1: Text[50];
//         locationadd2: Text[50];
//         locationaddCitypost: Text[50];
//         locationEmail: Text;
//         "locationPhnNo.": Text;
//         locationTIN: Text[20];
//         SalesCommLine: Record "Sales Comment Line";
//         CommentDesc: Text[500];
//         AuthSignTitle: Text;
//         TaxInvoiceAuthDesig: Text;
//         ShowWarrAndSupp: Boolean;
//         RecDocu: Code[50];
//         AddtAxPerc: Decimal;
//         CashRcptAmt: Decimal;
//         LedgerAcct1Name: Text;
//         LedgerAcct2Name: Text;
//         LedgerAcct3Name: Text;
//         LedgerAcct4Name: Text;
//         LedgerAcct5Name: Text;
//         LedgerAcct6Name: Text;
//         LedgerAcct7Name: Text;
//         LedgerAcct8Name: Text;
//         LedgerAcct9Name: Text;
//         LedgerAcct10Name: Text;
//         LedgerAcct1Amt: Decimal;
//         LedgerAcct2Amt: Decimal;
//         LedgerAcct3Amt: Decimal;
//         LedgerAcct4Amt: Decimal;
//         LedgerAcct5Amt: Decimal;
//         LedgerAcct6Amt: Decimal;
//         LedgerAcct7Amt: Decimal;
//         LedgerAcct8Amt: Decimal;
//         LedgerAcct9Amt: Decimal;
//         LedgerAcct10Amt: Decimal;
//         IsGSTApplicable: Boolean;
//         GSTComponent: Record "GST Component";
//         GSTComponentCode: array[5] of Text;
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//         GSTCompAmount: array[5] of Decimal;
//         J: Integer;
//         // StructureLineDetails: Record "Posted Str Order Line Details";
//         ChargesAmount: Decimal;
//         OtherTaxesAmount: Decimal;
//         SalesInvLineGLAcct: Record "Sales Invoice Line";
//         ItemGSTTemp: Decimal;
//         ItemGSTAmt: array[4] of Decimal;
//         GSTBaseAmount: array[4] of Decimal;
//         ResvEntCount: Integer;
//         CustStateCodeTitle: label 'Customer State Code';
//         CustStateCodeValue: Text;
//         StateRec: Record State;

//     procedure SetFields(LocalDocumentno: Code[50])
//     begin
//         //RecDocu:=LocalDocumentno;
//     end;

// }
