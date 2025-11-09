// Report 50073 "Purchase Order New"
// {
//     RDLCLayout = './Layouts/PurchaseOrderNew.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Purchase Header"; "Purchase Header")
//         {
//             column(SBCessPerc; 'SBCess @0.5%')
//             {
//             }
//             column(SBCess; SBCess)
//             {
//             }
//             column(KKCess; KKCess)
//             {
//             }
//             column(Cmp_Name; COMPANYNAME)
//             {
//             }
//             column(Logo; Cmp.Picture)
//             {
//             }
//             column(CIN_NO; Cmp."Registration No.")
//             {
//             }
//             column(Cmp_Add1; Cmp.Address)
//             {
//             }
//             column(Cmp_Add2; Cmp."Address 2")
//             {
//             }
//             column(Cmp_City; Cmp.City)
//             {
//             }
//             column(Cmp_Phone; Cmp."Phone No.")
//             {
//             }
//             column(Cmp_Fax; Cmp."Fax No.")
//             {
//             }
//             column(Cmp_Email; Cmp."E-Mail")
//             {
//             }
//             column(Cmp_Tin; Cmp.t)
//             {
//             }
//             column(Cmp_Stax; Cmp."GST Registration No.")
//             {
//             }
//             column(Inv_No; "Purchase Header"."No.")
//             {
//             }
//             column(SellToNo; "Purchase Header"."Buy-from Vendor No.")
//             {
//             }
//             column(BilltoName; "Purchase Header"."Buy-from Vendor Name")
//             {
//             }
//             column(BilltoAdd1; "Purchase Header"."Buy-from Address")
//             {
//             }
//             column(BillToAddr2; "Purchase Header"."Buy-from Address 2")
//             {
//             }
//             column(BillToCity; "Purchase Header"."Buy-from City")
//             {
//             }
//             column(ShipToAdd; "Purchase Header"."Pay-to Post Code")
//             {
//             }
//             column(ShiptoAdd2; "Purchase Header"."Pay-to County")
//             {
//             }
//             column(Vorder; "Purchase Header"."Vendor Order No.")
//             {
//             }
//             column(Order_Dt; "Purchase Header"."Order Date")
//             {
//             }
//             column(PostinG_Date; "Purchase Header"."Posting Date")
//             {
//             }
//             column(Pymt_Terms; "Purchase Header"."Payment Terms Code")
//             {
//             }
//             column(Due_Date; "Purchase Header"."Payment Terms Code")
//             {
//             }
//             column(ShiptoName; "Purchase Header"."Ship-to Name")
//             {
//             }
//             column(ShiptoName2; "Purchase Header"."Ship-to Name 2")
//             {
//             }
//             column(ShiptoAddress; "Purchase Header"."Ship-to Address")
//             {
//             }
//             column(ShiptoAddress2; "Purchase Header"."Ship-to Address 2")
//             {
//             }
//             column(ShiptoCity; "Purchase Header"."Ship-to City")
//             {
//             }
//             column(FormCode; '"Purchase Header"."Form Code"')
//             {
//             }
//             column(locationadd; locationadd)
//             {
//             }
//             column(locationadd1; locationadd1)
//             {
//             }
//             column(locationaddCityposts; locationaddCitypost)
//             {
//             }
//             column(locationadd2; locationadd2)
//             {
//             }
//             column(locationTIN; locationTIN)
//             {
//             }
//             column(CurrencyCode; "Purchase Line"."Currency Code")
//             {
//             }
//             column(LocationServiceTax; LocationServiceTax)
//             {
//             }
//             column(vendortin; vendortin)
//             {
//             }
//             column(ServiceTxPer; Format(ServiceTxPer) + '%')
//             {
//             }
//             column(vendorservicetax; vendorservicetax)
//             {
//             }
//             column(Mode_Tpt; "Purchase Header"."Transport Method")
//             {
//             }
//             dataitem("Purchase Line"; "Purchase Line")
//             {
//                 DataItemLink = "Document No." = field("No.");
//                 DataItemTableView = where(Type = filter(<> "Charge (Item)"));
//                 column(VendorItem; vendoritemname)
//                 {
//                 }
//                 column(DocumentNo; "Purchase Line"."Document No.")
//                 {
//                 }
//                 column(Taxgroupcode; "Purchase Line"."Tax Group Code")
//                 {
//                 }
//                 column(Line_No; "Purchase Line"."Line No.")
//                 {
//                 }
//                 column(Item_Type; "Purchase Line".Type)
//                 {
//                 }
//                 column(Item_No; "Purchase Line"."No.")
//                 {
//                 }
//                 column(Item_Desc; "Purchase Line".Description)
//                 {
//                 }
//                 column(Item_Unit; "Purchase Line"."Unit of Measure Code")
//                 {
//                 }
//                 column(Item_Qty; "Purchase Line".Quantity)
//                 {
//                 }
//                 column(Item_Price; "Purchase Line"."Direct Unit Cost")
//                 {
//                 }
//                 column(Item_Disc; "Purchase Line"."Line Discount %")
//                 {
//                 }
//                 column(Item_Amt; "Purchase Line".Amount)
//                 {
//                 }
//                 column(vatamount; vatamount)
//                 {
//                 }
//                 column(Totaltaxamount; "Purchase Line"."Tax Amount")
//                 {
//                 }
//                 column(TAXECEAMOUNT; "Purchase Line"."Service Tax eCess Amount")
//                 {
//                 }
//                 column(SHECESSAMOUNT; "Purchase Line"."Service Tax SHE Cess Amount")
//                 {
//                 }
//                 column(SERVICESTAXAMOUNT; "Purchase Line"."Service Tax Amount")
//                 {
//                 }
//                 column(Lineamountsum; Lineamountsum)
//                 {
//                 }
//                 column(Numbertext; Numbertext[1])
//                 {
//                 }
//                 column(Numbertext2; Numbertext[2])
//                 {
//                 }
//                 column(NewTotal; NewTotal)
//                 {
//                 }
//                 column(allamount; allamount)
//                 {
//                 }
//                 column(textstring; textstring)
//                 {
//                 }
//                 column(qunty; qunty)
//                 {
//                 }
//                 trigger OnAfterGetRecord();
//                 begin
//                     item.Reset;
//                     item.SetRange(item."No.", "Purchase Line"."No.");
//                     if item.FindFirst then
//                         vendoritemname := item."Vendor Item No.";
//                     /*
//                       totalamount := 0;
//                       TOTALSERVTAXAMOUNT := 0;
//                        totalservtaxeceamount := 0;
//                        totalservestaxsheceesamount :=0;
//                        Lineamountsum :=0;
//                                              */
//                     totalamount += "Purchase Line"."Tax Amount" + "Purchase Line"."Charges To Vendor";
//                     //message(format(totalamount));
//                     TOTALSERVTAXAMOUNT += "Purchase Line"."Service Tax Amount";
//                     totalservtaxeceamount += "Purchase Line"."Service Tax eCess Amount";
//                     totalservestaxsheceesamount += "Purchase Line"."Service Tax SHE Cess Amount";
//                     Lineamountsum += "Purchase Line"."Line Amount";
//                     //message(format(Lineamountsum));
//                     allamount := 0;
//                     allamount := (TOTALSERVTAXAMOUNT + totalservtaxeceamount + totalservestaxsheceesamount + totalamount + Lineamountsum);
//                     //PostedVchr.InitTextVariable;
//                     //PostedVchr.FormatNoText(Numbertext,allamount,"Purchase Line"."Currency Code");
//                     // message(format(allamount ));
//                     //vatamount:=round((Lineamountsum/totalamount)*100);
//                     // message(format(vatamount));
//                     if "Purchase Line"."No." = 'P-FREIGHT' then begin
//                         vendoritemname := '';
//                         "Purchase Line".Description := '';
//                         CurrReport.Skip;
//                     end;
//                     NewTotal := allamount + framunt;
//                     //MESSAGE(FORMAT(NewTotal));
//                     PostedVchr.InitTextVariable;
//                     PostedVchr.FormatNoText(Numbertext, NewTotal, "Purchase Line"."Currency Code");

//                 end;

//             }
//             trigger OnPreDataItem();
//             begin
//                 //comany.GET;
//                 Cmp.Get; // THEN
//                          // BEGIN
//                          //comany.CALCFIELDS(comany.Picture);
//                 Cmp.CalcFields(Picture);
//                 // END;
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 location.Reset;
//                 location.SetRange(location.Code, "Purchase Header"."Location Code");
//                 if location.FindFirst then
//                     locationadd2 := location.Name;
//                 locationadd := location.Address;
//                 locationadd1 := location."Address 2";
//                 locationaddCitypost := location.City + location."Post Code";
//                 locationTIN := 'TIN No.' + location."T.I.N. No.";
//                 LocationServiceTax := 'Service Tax No.' + location."Service Tax Registration No.";
//                 vendor.Reset;
//                 vendor.SetRange(vendor."No.", "Purchase Header"."Buy-from Vendor No.");
//                 if vendor.FindFirst then
//                     vendortin := 'TIN No. ' + vendor."T.I.N. No.";
//                 vendorservicetax := 'Service Tax No. ' + vendor."Service Tax Registration No.";
//                 totalamount += "Purchase Line"."Tax Amount";
//                 locaction1.Reset;
//                 locaction1.SetRange(locaction1.Code, "Purchase Header"."Location Code");
//                 if locaction1.FindFirst then begin
//                     if locaction1."State Code" = "Purchase Header".State then
//                         textstring := 'Vat Amount'
//                     else
//                         textstring := 'CST Amount';
//                 end;
//                 ServiceTxSetup.Reset;
//                 if ServiceTxSetup.FindLast then begin
//                     FromDate := ServiceTxSetup."From Date";
//                     if "Posting Date" >= FromDate then
//                         ServiceTxPer := ServiceTxSetup."Service Tax %"
//                     else
//                         ServiceTxPer := 12;
//                 end;
//                 //sbcess antim
//                 /*   SBCessPerc := 0;
//                   SBCess := 0;
//                   StrOrdLineDet.Reset;
//                   StrOrdLineDet.SetRange(StrOrdLineDet."Document No.", "No.");
//                   StrOrdLineDet.SetRange(StrOrdLineDet.Type, StrOrdLineDet.Type::Purchase);
//                   StrOrdLineDet.SetRange(StrOrdLineDet."Tax/Charge Code", 'SBCESS');
//                   if StrOrdLineDet.FindFirst then
//                       repeat
//                           SBCess := SBCess + StrOrdLineDet.Amount;
//                           SBCessPerc := StrOrdLineDet."Calculation Value";
//                       until StrOrdLineDet.Next = 0;
//                   KKCess := 0;
//                   StrOrdLineDet.Reset;
//                   StrOrdLineDet.SetRange(StrOrdLineDet."Document No.", "No.");
//                   StrOrdLineDet.SetRange(StrOrdLineDet.Type, StrOrdLineDet.Type::Purchase);
//                   StrOrdLineDet.SetRange(StrOrdLineDet."Tax/Charge Code", 'KKCESS');
//                   if StrOrdLineDet.FindFirst then
//                       repeat
//                           KKCess += StrOrdLineDet.Amount;
//                       until StrOrdLineDet.Next = 0; */ // Lk (Structure Table missing )
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
//         Cmp: Record "Company Information";
//         item: Record Item;
//         vendoritemname: Text;
//         location: Record Location;
//         locationadd: Text[50];
//         locationadd1: Text[50];
//         locationadd2: Text[50];
//         locationaddCitypost: Text[50];
//         locationTIN: Text[20];
//         LocationServiceTax: Text[50];
//         LocationPAN: Text[50];
//         vendor: Record Vendor;
//         vendortin: Text[50];
//         vendorservicetax: Text[50];
//         totalamount: Decimal;
//         totalservtaxeceamount: Decimal;
//         totalservestaxsheceesamount: Decimal;
//         TOTALSERVTAXAMOUNT: Decimal;
//         Lineamountsum: Decimal;
//         ReportCheck: Report Check;
//         Numbertext: array[5] of Text[250];
//         PostedVchr: Report "Posted Voucher";
//         allamount: Decimal;
//         locaction1: Record Location;
//         vendor1: Record Vendor;
//         textstring: Text[20];
//         framunt: Decimal;
//         qunty: Text[50];
//         NewTotal: Decimal;
//         vatamount: Decimal;
//         ServiceTxSetup: Record "Service Tax Setup";
//         ServiceTxPer: Decimal;
//         FromDate: Date;
//         SBCessPerc: Decimal;
//         SBCess: Decimal;
//         // StrOrdLineDet: Record "Structure Order Line Details";
//         KKCess: Decimal;

// }