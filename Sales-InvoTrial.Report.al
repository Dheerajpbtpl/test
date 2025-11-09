// Report 50206 "Sales - InvoTrial"
// {
//     Caption = 'Sales - Invoice';
//     Permissions = TableData "Sales Shipment Buffer" = rimd;
//     RDLCLayout = './Layouts/Sales-InvoTrial.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {
//             DataItemTableView = sorting("No.");
//             RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
//             RequestFilterHeading = 'Posted Sales Invoice';
//             column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
//             {
//             }
//             column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
//             {
//             }
//             column(VATPercentageCaption; VATPercentageCaptionLbl)
//             {
//             }
//             column(VATAmountCaption; VATAmountCaptionLbl)
//             {
//             }
//             column(VATIdentifierCaption; VATIdentifierCaptionLbl)
//             {
//             }
//             column(TotalCaption; TotalCaptionLbl)
//             {
//             }
//             column(VATBaseCaption; VATBaseCaptionLbl)
//             {
//             }
//             column(PaymentTermsCaption; PaymentTermsCaptionLbl)
//             {
//             }
//             column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
//             {
//             }
//             column(EMailCaption; EMailCaptionLbl)
//             {
//             }
//             column(DocumentDateCaption; DocumentDateCaptionLbl)
//             {
//             }
//             dataitem(CopyLoop; Integer)
//             {
//                 DataItemTableView = sorting(Number);
//                 dataitem(PageLoop; Integer)
//                 {
//                     DataItemTableView = sorting(Number) where(Number = const(1));
//                     column(CompanyInfo2Picture; CompanyInfo2.Picture)
//                     {
//                     }
//                     column(CompanyInfo1Picture; CompanyInfo1.Picture)
//                     {
//                     }
//                     column(CompanyInfo3Picture; CompanyInfo3.Picture)
//                     {
//                     }
//                     column(DocumentCaptionCopyText; StrSubstNo(DocumentCaption, CopyText))
//                     {
//                     }
//                     column(CustAddr1; CustAddr[1])
//                     {
//                     }
//                     column(CompanyAddr1; CompanyAddr[1])
//                     {
//                     }
//                     column(CustAddr2; CustAddr[2])
//                     {
//                     }
//                     column(CompanyAddr2; CompanyAddr[2])
//                     {
//                     }
//                     column(CustAddr3; CustAddr[3])
//                     {
//                     }
//                     column(CompanyAddr3; CompanyAddr[3])
//                     {
//                     }
//                     column(CustAddr4; CustAddr[4])
//                     {
//                     }
//                     column(CompanyAddr4; CompanyAddr[4])
//                     {
//                     }
//                     column(CustAddr5; CustAddr[5])
//                     {
//                     }
//                     column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
//                     {
//                     }
//                     column(CustAddr6; CustAddr[6])
//                     {
//                     }
//                     column(PaymentTermsDescription; PaymentTerms.Description)
//                     {
//                     }
//                     column(ShipmentMethodDescription; ShipmentMethod.Description)
//                     {
//                     }
//                     column(CompanyInfoHomePage; CompanyInfo."Home Page")
//                     {
//                     }
//                     column(CompanyInfoEMail; CompanyInfo."E-Mail")
//                     {
//                     }
//                     column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
//                     {
//                     }
//                     column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
//                     {
//                     }
//                     column(CompanyInfoBankName; CompanyInfo."Bank Name")
//                     {
//                     }
//                     column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
//                     {
//                     }
//                     column(BillToCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
//                     {
//                     }
//                     column(PostingDate_SalesInvHdr; Format("Sales Invoice Header"."Posting Date"))
//                     {
//                     }
//                     column(VATNoText; VATNoText)
//                     {
//                     }
//                     column(VATRegNo_SalesInvHdr; "Sales Invoice Header"."VAT Registration No.")
//                     {
//                     }
//                     column(DueDate_SalesInvoiceHdr; Format("Sales Invoice Header"."Due Date"))
//                     {
//                     }
//                     column(SalesPersonText; SalesPersonText)
//                     {
//                     }
//                     column(SalesPurchPersonName; SalesPurchPerson.Name)
//                     {
//                     }
//                     column(ReferenceText; ReferenceText)
//                     {
//                     }
//                     column(YourReference_SalesInvHdr; "Sales Invoice Header"."Your Reference")
//                     {
//                     }
//                     column(OrderNoText; OrderNoText)
//                     {
//                     }
//                     column(OrderNo_SalesInvoiceHdr; "Sales Invoice Header"."Order No.")
//                     {
//                     }
//                     column(CustAddr7; CustAddr[7])
//                     {
//                     }
//                     column(CustAddr8; CustAddr[8])
//                     {
//                     }
//                     column(CompanyAddr5; CompanyAddr[5])
//                     {
//                     }
//                     column(CompanyAddr6; CompanyAddr[6])
//                     {
//                     }
//                     column(DocDate_SalesInvHeader; Format("Sales Invoice Header"."Document Date", 0, 4))
//                     {
//                     }
//                     column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
//                     {
//                     }
//                     column(OutputNo; OutputNo)
//                     {
//                     }
//                     column(PricesInclVATYesNo; Format("Sales Invoice Header"."Prices Including VAT"))
//                     {
//                     }
//                     column(PageCaption; StrSubstNo(Text005, ''))
//                     {
//                     }
//                     column(PLAEntryNo_SalesInvHdr; "Sales Invoice Header"."PLA Entry No.")
//                     {
//                     }
//                     column(SupplementaryText; SupplementaryText)
//                     {
//                     }
//                     column(RG23AEntryNo_SalesInvHdr; "Sales Invoice Header"."RG 23 A Entry No.")
//                     {
//                     }
//                     column(RG23CEntryNo_SalesInvHdr; "Sales Invoice Header"."RG 23 C Entry No.")
//                     {
//                     }
//                     column(PhoneNoCaption; PhoneNoCaptionLbl)
//                     {
//                     }
//                     column(HomePageCaption; HomePageCaptionLbl)
//                     {
//                     }
//                     column(VATRegNoCaption; VATRegNoCaptionLbl)
//                     {
//                     }
//                     column(GiroNoCaption; GiroNoCaptionLbl)
//                     {
//                     }
//                     column(BankNameCaption; BankNameCaptionLbl)
//                     {
//                     }
//                     column(BankAccNoCaption; BankAccNoCaptionLbl)
//                     {
//                     }
//                     column(DueDateCaption; DueDateCaptionLbl)
//                     {
//                     }
//                     column(InvoiceNoCaption; InvoiceNoCaptionLbl)
//                     {
//                     }
//                     column(PostingDateCaption; PostingDateCaptionLbl)
//                     {
//                     }
//                     column(PLAEntryNoCaption; PLAEntryNoCaptionLbl)
//                     {
//                     }
//                     column(RG23AEntryNoCaption; RG23AEntryNoCaptionLbl)
//                     {
//                     }
//                     column(RG23CEntryNoCaption; RG23CEntryNoCaptionLbl)
//                     {
//                     }
//                     column(ServiceTaxRegistrationNoCaption; ServiceTaxRegistrationNoLbl)
//                     {
//                     }
//                     column(ServiceTaxRegistrationNo; ServiceTaxRegistrationNo)
//                     {
//                     }
//                     column(BillToCustNo_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Bill-to Customer No."))
//                     {
//                     }
//                     column(PricesInclVAT_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Prices Including VAT"))
//                     {
//                     }
//                     dataitem(DimensionLoop1; Integer)
//                     {
//                         DataItemLinkReference = "Sales Invoice Header";
//                         DataItemTableView = sorting(Number) where(Number = filter(1 ..));
//                         column(DimText_DimensionLoop1; DimText)
//                         {
//                         }
//                         column(Number_Integer; DimensionLoop1.Number)
//                         {
//                         }
//                         column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
//                         {
//                         }
//                         trigger OnPreDataItem();
//                         begin
//                             if not ShowInternalInfo then
//                                 CurrReport.Break;
//                         end;

//                         trigger OnAfterGetRecord();
//                         begin
//                             if Number = 1 then begin
//                                 if not DimSetEntry1.FindSet then
//                                     CurrReport.Break;
//                             end else
//                                 if not Continue then
//                                     CurrReport.Break;
//                             Clear(DimText);
//                             Continue := false;
//                             repeat
//                                 OldDimText := DimText;
//                                 if DimText = '' then
//                                     DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
//                                 else
//                                     DimText :=
//                                       StrSubstNo(
//                                         '%1, %2 %3', DimText,
//                                         DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
//                                 if StrLen(DimText) > MaxStrLen(OldDimText) then begin
//                                     DimText := OldDimText;
//                                     Continue := true;
//                                     exit;
//                                 end;
//                             until DimSetEntry1.Next = 0;
//                         end;

//                     }
//                     dataitem("Sales Invoice Line"; "Sales Invoice Line")
//                     {
//                         DataItemLink = "Document No." = field("No.");
//                         DataItemLinkReference = "Sales Invoice Header";
//                         DataItemTableView = sorting("Document No.", "Line No.");
//                         column(LineAmount_SalesInvLine; "Sales Invoice Line"."Line Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(Description_SalesInvLine; "Sales Invoice Line".Description)
//                         {
//                         }
//                         column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
//                         {
//                         }
//                         column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
//                         {
//                         }
//                         column(UOM_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure")
//                         {
//                         }
//                         column(UnitPrice_SalesInvLine; "Sales Invoice Line"."Unit Price")
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 2;
//                         }
//                         column(LineDiscount_SalesInvLine; "Sales Invoice Line"."Line Discount %")
//                         {
//                         }
//                         column(LineDiscount_SalesInvLineAmount; "Sales Invoice Line"."Line Discount Amount")
//                         {
//                         }
//                         column(PostedShipmentDate; Format(PostedShipmentDate))
//                         {
//                         }
//                         column(SalesLineType; Format("Sales Invoice Line".Type))
//                         {
//                         }
//                         column(DirectDebitPLARG_SalesInvLine; "Sales Invoice Line"."Direct Debit To PLA / RG")
//                         {
//                         }
//                         column(SourceDocNo_SalesInvLine; "Sales Invoice Line"."Source Document No.")
//                         {
//                         }
//                         column(Supplementary; "Sales Invoice Line".Supplementary)
//                         {
//                         }
//                         column(InvDiscountAmount; -"Inv. Discount Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(TotalSubTotal; TotalSubTotal)
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalInvoiceDiscAmount; TotalInvoiceDiscountAmount)
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalText; TotalText)
//                         {
//                         }
//                         column(SalesInvoiceLineAmount; "Sales Invoice Line".Amount)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(TotalAmount; TotalAmount)
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(AmtInclVAT_SalesInvLine; Amount_To_Cust)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(TotalInclVATText; TotalInclVATText)
//                         {
//                         }
//                         column(TotalAmountInclVAT; TotalAmountInclVAT)
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TaxAmount_SalesInvLine; GSTAmount)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(ServiceTaxAmt; ServiceTaxAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(ChargesAmount; ChargesAmount)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(OtherTaxesAmount; OtherTaxesAmount)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(ServiceTaxECessAmt; ServiceTaxECessAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(SalesInvLineTotalTDSTCSInclSHECESS; TotalTCSAmount)
//                         {
//                         }
//                         column(AppliedServiceTaxAmt; AppliedServiceTaxAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(AppliedServiceTaxECessAmt; AppliedServiceTaxECessAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(ServiceTaxSHECessAmt; ServiceTaxSHECessAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(AppliedServTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(TotalTaxAmt; TotalTaxAmt)
//                         {
//                         }
//                         column(TotalExciseAmt; TotalExciseAmt)
//                         {
//                         }
//                         column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalPaymentDiscountOnVAT; TotalPaymentDiscountOnVAT)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
//                         {
//                         }
//                         column(TotalExclVATText; TotalExclVATText)
//                         {
//                         }
//                         column(TotalAmountVAT; TotalAmountVAT)
//                         {
//                         }
//                         column(SalesInvoiceLineLineNo; "Sales Invoice Line"."Line No.")
//                         {
//                         }
//                         column(UnitPriceCaption; UnitPriceCaptionLbl)
//                         {
//                         }
//                         column(DiscountCaption; DiscountCaptionLbl)
//                         {
//                         }
//                         column(AmountCaption; AmountCaptionLbl)
//                         {
//                         }
//                         column(LineDiscountCaption; LineDiscountCaptionLbl)
//                         {
//                         }
//                         column(PostedShipmentDateCaption; PostedShipmentDateCaptionLbl)
//                         {
//                         }
//                         column(SubtotalCaption; SubtotalCaptionLbl)
//                         {
//                         }
//                         column(ExciseAmountCaption; ExciseAmountCaptionLbl)
//                         {
//                         }
//                         column(TaxAmountCaption; TaxAmountCaptionLbl)
//                         {
//                         }
//                         column(ServiceTaxAmountCaption; ServiceTaxAmountCaptionLbl)
//                         {
//                         }
//                         column(ChargesAmountCaption; ChargesAmountCaptionLbl)
//                         {
//                         }
//                         column(OtherTaxesAmountCaption; OtherTaxesAmountCaptionLbl)
//                         {
//                         }
//                         column(ServTaxeCessAmtCaption; ServTaxeCessAmtCaptionLbl)
//                         {
//                         }
//                         column(TCSAmountCaption; TCSAmountCaptionLbl)
//                         {
//                         }
//                         column(SvcTaxAmtAppliedCaption; SvcTaxAmtAppliedCaptionLbl)
//                         {
//                         }
//                         column(SvcTaxeCessAmtAppliedCaption; SvcTaxeCessAmtAppliedCaptionLbl)
//                         {
//                         }
//                         column(ServTaxSHECessAmtCaption; ServTaxSHECessAmtCaptionLbl)
//                         {
//                         }
//                         column(SvcTaxSHECessAmtAppliedCaption; SvcTaxSHECessAmtAppliedCaptionLbl)
//                         {
//                         }
//                         column(PaymentDiscVATCaption; PaymentDiscVATCaptionLbl)
//                         {
//                         }
//                         column(Description_SalesInvLineCaption; FieldCaption(Description))
//                         {
//                         }
//                         column(No_SalesInvoiceLineCaption; FieldCaption("No."))
//                         {
//                         }
//                         column(Quantity_SalesInvoiceLineCaption; FieldCaption(Quantity))
//                         {
//                         }
//                         column(UOM_SalesInvoiceLineCaption; FieldCaption("Unit of Measure"))
//                         {
//                         }
//                         column(DirectDebitPLARG_SalesInvLineCaption; FieldCaption("Direct Debit To PLA / RG"))
//                         {
//                         }
//                         dataitem("Sales Shipment Buffer"; Integer)
//                         {
//                             DataItemTableView = sorting(Number);
//                             column(SalesShpBufferPostingDate; Format(SalesShipmentBuffer."Posting Date"))
//                             {
//                             }
//                             column(SalesShipmentBufferQty; SalesShipmentBuffer.Quantity)
//                             {
//                                 DecimalPlaces = 0 : 5;
//                             }
//                             column(ShipmentCaption; ShipmentCaptionLbl)
//                             {
//                             }
//                             trigger OnPreDataItem();
//                             begin
//                                 SalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
//                                 SalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
//                                 SetRange(Number, 1, SalesShipmentBuffer.Count);
//                             end;

//                             trigger OnAfterGetRecord();
//                             begin
//                                 if Number = 1 then
//                                     SalesShipmentBuffer.Find('-')
//                                 else
//                                     SalesShipmentBuffer.Next;
//                             end;

//                         }
//                         dataitem(DimensionLoop2; Integer)
//                         {
//                             DataItemTableView = sorting(Number) where(Number = filter(1 ..));
//                             column(DimText_DimensionLoop2; DimText)
//                             {
//                             }
//                             column(LineDimensionsCaption; LineDimensionsCaptionLbl)
//                             {
//                             }
//                             trigger OnPreDataItem();
//                             begin
//                                 if not ShowInternalInfo then
//                                     CurrReport.Break;
//                                 DimSetEntry2.SetRange("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
//                             end;

//                             trigger OnAfterGetRecord();
//                             begin
//                                 if Number = 1 then begin
//                                     if not DimSetEntry2.FindSet then
//                                         CurrReport.Break;
//                                 end else
//                                     if not Continue then
//                                         CurrReport.Break;
//                                 Clear(DimText);
//                                 Continue := false;
//                                 repeat
//                                     OldDimText := DimText;
//                                     if DimText = '' then
//                                         DimText := StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
//                                     else
//                                         DimText :=
//                                           StrSubstNo(
//                                             '%1, %2 %3', DimText,
//                                             DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
//                                     if StrLen(DimText) > MaxStrLen(OldDimText) then begin
//                                         DimText := OldDimText;
//                                         Continue := true;
//                                         exit;
//                                     end;
//                                 until DimSetEntry2.Next = 0;
//                             end;

//                         }
//                         dataitem(AsmLoop; Integer)
//                         {
//                             DataItemTableView = sorting(Number);
//                             column(TempPostedAsmLineNo; BlanksForIndent + TempPostedAsmLine."No.")
//                             {
//                             }
//                             column(TempPostedAsmLineDescription; BlanksForIndent + TempPostedAsmLine.Description)
//                             {
//                             }
//                             column(TempPostedAsmLineVariantCode; BlanksForIndent + TempPostedAsmLine."Variant Code")
//                             {
//                                 // DecimalPlaces = 0 : 5;
//                             }
//                             column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
//                             {
//                                 DecimalPlaces = 0 : 5;
//                             }
//                             column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
//                             {
//                                 // DecimalPlaces = 0 : 5;
//                             }
//                             trigger OnPreDataItem();
//                             begin
//                                 Clear(TempPostedAsmLine);
//                                 if not DisplayAssemblyInformation then
//                                     CurrReport.Break;
//                                 CollectAsmInformation;
//                                 Clear(TempPostedAsmLine);
//                                 SetRange(Number, 1, TempPostedAsmLine.Count);
//                             end;

//                             trigger OnAfterGetRecord();
//                             begin
//                                 if Number = 1 then
//                                     TempPostedAsmLine.FindSet
//                                 else
//                                     TempPostedAsmLine.Next;
//                             end;

//                         }
//                         trigger OnPreDataItem();
//                         begin
//                             VATAmountLine.DeleteAll;
//                             SalesShipmentBuffer.Reset;
//                             SalesShipmentBuffer.DeleteAll;
//                             FirstValueEntryNo := 0;
//                             MoreLines := Find('+');
//                             while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
//                                 MoreLines := Next(-1) <> 0;
//                             if not MoreLines then
//                                 CurrReport.Break;
//                             SetRange("Line No.", 0, "Line No.");


//                         end;

//                         trigger OnAfterGetRecord();
//                         var
//                         // StructureLineDetails: Record "Posted Str Order Line Details";
//                         begin
//                             PostedShipmentDate := 0D;
//                             if Quantity <> 0 then
//                                 PostedShipmentDate := FindPostedShipmentDate;
//                             if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
//                                 "No." := '';
//                             //<<<<<<<<<<<<<LK Start>>>>>>>>>>>>>>>>.
//                             Amount_To_Cust := 0;
//                             CustLedEntry.Reset();
//                             CustLedEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
//                             CustLedEntry.CalcFields(Amount);
//                             Amount_To_Cust := CustLedEntry.Amount;

//                             GSTAmount := 0;
//                             Clear(CGSTAmount);
//                             Clear(IGSTAmount);
//                             Clear(SGSTAmount);
//                             DetailGSTLedEnrty.Reset();
//                             DetailGSTLedEnrty.SetRange("Document No.", "Sales Invoice Line"."Document No.");
//                             DetailGSTLedEnrty.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
//                             DetailGSTLedEnrty.SetRange("Transaction Type", DetailGSTLedEnrty."Transaction Type"::Sales);
//                             DetailGSTLedEnrty.CALCSUMS(DetailGSTLedEnrty."GST Amount");
//                             if DetailGSTLedEnrty.FindFirst then begin
//                                 repeat
//                                     if DetailGSTLedEnrty."GST Component Code" = 'CGST' then begin
//                                         CGSTAmount  := Abs(DetailGSTLedEnrty."GST Amount");
//                                         // CGSTPer := DLE."GST %";
//                                         // GstAmount := DetailGSTLedEnrty."GST Base Amount";
//                                     end;
//                                     if DetailGSTLedEnrty."GST Component Code" = 'SGST' then begin
//                                         SGSTAmount := Abs(DetailGSTLedEnrty."GST Amount");
//                                         // SGSTPer := DLE."GST %";
//                                         // GstAmount := DetailGSTLedEnrty."GST Base Amount";
//                                     end;
//                                     if DetailGSTLedEnrty."GST Component Code" = 'IGST' then begin
//                                         IGSTAmount := Abs(DetailGSTLedEnrty."GST Amount");
//                                         // IGSTPer := DLE."GST %";
//                                         // GstAmount := DetailGSTLedEnrty."GST Base Amount";
//                                     end;
//                                     GSTAmount := CGSTAmount + IGSTAmount + SGSTAmount;
//                                 until DetailGSTLedEnrty.Next = 0;
//                             end;
//                             //<<<<<<<<<<<<<<<<<<<<LK End>>>>>>>>>>>>>>>>>>>>

//                             VATAmountLine.Init;
//                             VATAmountLine."VAT Identifier" := "VAT Identifier";
//                             VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
//                             VATAmountLine."Tax Group Code" := "Tax Group Code";
//                             VATAmountLine."VAT %" := "VAT %";
//                             VATAmountLine."VAT Base" := Amount;
//                             VATAmountLine."Amount Including VAT" := "Amount Including VAT";
//                             VATAmountLine."Line Amount" := "Line Amount";
//                             if "Allow Invoice Disc." then
//                                 VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
//                             VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
//                             VATAmountLine.InsertLine;
//                             TotalTCSAmount += "Total TDS/TCS Incl. SHE CESS";
//                             TotalSubTotal += "Line Amount";
//                             TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
//                             TotalAmount += Amount;
//                             TotalAmountVAT += "Amount Including VAT" - Amount;
//                             // TotalAmountInclVAT += "Amount Including VAT";
//                             TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
//                             //IN0090.begin
//                             // TotalAmountInclVAT += "Amount To Customer";
//                             TotalAmountInclVAT := Amount_To_Cust;
//                             TotalTaxAmt := GSTAmount;
//                             TotalExciseAmt += "Excise Amount";
//                             // TotalTaxAmt += "Tax Amount";
//                             ServiceTaxAmount += "Service Tax Amount";
//                             ServiceTaxeCessAmount += "Service Tax eCess Amount";
//                             ServiceTaxSHECessAmount += "Service Tax SHE Cess Amount";
//                             //IN0090.end
//                             /*   StructureLineDetails.Reset;
//                               StructureLineDetails.SetRange(Type, StructureLineDetails.Type::Sale);
//                               StructureLineDetails.SetRange("Document Type", StructureLineDetails."document type"::Invoice);
//                               StructureLineDetails.SetRange("Invoice No.", "Document No.");
//                               StructureLineDetails.SetRange("Item No.", "No.");
//                               StructureLineDetails.SetRange("Line No.", "Line No.");
//                               if StructureLineDetails.Find('-') then
//                                   repeat
//                                       if not StructureLineDetails."Payable to Third Party" then begin
//                                           if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::Charges then
//                                               ChargesAmount := ChargesAmount + Abs(StructureLineDetails.Amount);
//                                           if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::"Other Taxes" then
//                                               OtherTaxesAmount := OtherTaxesAmount + Abs(StructureLineDetails.Amount);
//                                       end;
//                                   until StructureLineDetails.Next = 0; */ //Lk (Structure Table missing )
//                                                                           //IN0090.begin
//                             if "Sales Invoice Header"."Transaction No. Serv. Tax" <> 0 then begin
//                                 ServiceTaxEntry.Reset;
//                                 ServiceTaxEntry.SetRange(Type, ServiceTaxEntry.Type::Sale);
//                                 ServiceTaxEntry.SetRange("Document Type", ServiceTaxEntry."document type"::Invoice);
//                                 ServiceTaxEntry.SetRange("Document No.", "Document No.");
//                                 if ServiceTaxEntry.FindFirst then begin
//                                     if "Sales Invoice Header"."Currency Code" <> '' then begin
//                                         ServiceTaxEntry."Service Tax Amount" :=
//                                           ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
//                                           "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
//                                           ServiceTaxEntry."Service Tax Amount", "Sales Invoice Header"."Currency Factor"));
//                                         ServiceTaxEntry."eCess Amount" :=
//                                           ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
//                                           "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
//                                           ServiceTaxEntry."eCess Amount", "Sales Invoice Header"."Currency Factor"));
//                                         ServiceTaxEntry."SHE Cess Amount" :=
//                                           ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
//                                           "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
//                                           ServiceTaxEntry."SHE Cess Amount", "Sales Invoice Header"."Currency Factor"));
//                                     end;
//                                     ServiceTaxAmt := Abs(ServiceTaxEntry."Service Tax Amount");
//                                     ServiceTaxECessAmt := Abs(ServiceTaxEntry."eCess Amount");
//                                     ServiceTaxSHECessAmt := Abs(ServiceTaxEntry."SHE Cess Amount");
//                                     AppliedServiceTaxAmt := ServiceTaxAmount - Abs(ServiceTaxEntry."Service Tax Amount");
//                                     AppliedServiceTaxECessAmt := ServiceTaxeCessAmount - Abs(ServiceTaxEntry."eCess Amount");
//                                     AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount - Abs(ServiceTaxEntry."SHE Cess Amount");
//                                 end else begin
//                                     AppliedServiceTaxAmt := ServiceTaxAmount;
//                                     AppliedServiceTaxECessAmt := ServiceTaxeCessAmount;
//                                     AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
//                                 end;
//                             end else begin
//                                 ServiceTaxAmt := ServiceTaxAmount;
//                                 ServiceTaxECessAmt := ServiceTaxeCessAmount;
//                                 ServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
//                             end;
//                             //IN0090.end
//                         end;

//                     }
//                     dataitem(VATCounter; Integer)
//                     {
//                         DataItemTableView = sorting(Number);
//                         column(VATAmountLineVATBase; VATAmountLine."VAT Base")
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmtLineVAT_VATCounter; VATAmountLine."VAT %")
//                         {
//                             DecimalPlaces = 0 : 5;
//                         }
//                         column(VATAmtLineVATIdentifier_VATCounter; VATAmountLine."VAT Identifier")
//                         {
//                         }
//                         column(VATAmountSpecificationCaption; VATAmountSpecificationCaptionLbl)
//                         {
//                         }
//                         column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
//                         {
//                         }
//                         column(LineAmountCaption; LineAmountCaptionLbl)
//                         {
//                         }
//                         trigger OnPreDataItem();
//                         begin
//                             SetRange(Number, 1, VATAmountLine.Count);

//                         end;

//                         trigger OnAfterGetRecord();
//                         begin
//                             VATAmountLine.GetLine(Number);
//                         end;

//                     }
//                     dataitem(VatCounterLCY; Integer)
//                     {
//                         DataItemTableView = sorting(Number);
//                         column(VALSpecLCYHeader; VALSpecLCYHeader)
//                         {
//                         }
//                         column(VALExchRate; VALExchRate)
//                         {
//                         }
//                         column(VALVATBaseLCY; VALVATBaseLCY)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(VALVATAmountLCY; VALVATAmountLCY)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmtLineVAT_VatCounterLCY; VATAmountLine."VAT %")
//                         {
//                             DecimalPlaces = 0 : 5;
//                         }
//                         column(VATAmtLineVATIdentifier_VatCounterLCY; VATAmountLine."VAT Identifier")
//                         {
//                         }
//                         trigger OnPreDataItem();
//                         begin
//                             if (not GLSetup."Print VAT specification in LCY") or
//                                ("Sales Invoice Header"."Currency Code" = '')
//                             then
//                                 CurrReport.Break;
//                             SetRange(Number, 1, VATAmountLine.Count);

//                             if GLSetup."LCY Code" = '' then
//                                 VALSpecLCYHeader := Text007 + Text008
//                             else
//                                 VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");
//                             CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
//                             CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
//                             VALExchRate := StrSubstNo(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
//                         end;

//                         trigger OnAfterGetRecord();
//                         begin
//                             VATAmountLine.GetLine(Number);
//                             VALVATBaseLCY := ROUND(VATAmountLine."VAT Base" / "Sales Invoice Header"."Currency Factor");
//                             VALVATAmountLCY := ROUND(VATAmountLine."VAT Amount" / "Sales Invoice Header"."Currency Factor");
//                         end;

//                     }
//                     dataitem(Total; Integer)
//                     {
//                         DataItemTableView = sorting(Number) where(Number = const(1));
//                     }
//                     dataitem(Total2; Integer)
//                     {
//                         DataItemTableView = sorting(Number) where(Number = const(1));
//                         column(SellToCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
//                         {
//                         }
//                         column(ShipToAddr1; ShipToAddr[1])
//                         {
//                         }
//                         column(ShipToAddr2; ShipToAddr[2])
//                         {
//                         }
//                         column(ShipToAddr3; ShipToAddr[3])
//                         {
//                         }
//                         column(ShipToAddr4; ShipToAddr[4])
//                         {
//                         }
//                         column(ShipToAddr5; ShipToAddr[5])
//                         {
//                         }
//                         column(ShipToAddr6; ShipToAddr[6])
//                         {
//                         }
//                         column(ShipToAddr7; ShipToAddr[7])
//                         {
//                         }
//                         column(ShipToAddr8; ShipToAddr[8])
//                         {
//                         }
//                         column(ShipToAddressCaption; ShipToAddressCaptionLbl)
//                         {
//                         }
//                         column(SellToCustNo_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Sell-to Customer No."))
//                         {
//                         }
//                         trigger OnPreDataItem();
//                         begin
//                             if not ShowShippingAddr then
//                                 CurrReport.Break;
//                         end;

//                     }
//                 }
//                 trigger OnPreDataItem();
//                 begin
//                     NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
//                     if NoOfLoops <= 0 then
//                         NoOfLoops := 1;
//                     CopyText := '';
//                     SetRange(Number, 1, NoOfLoops);
//                     OutputNo := 1;
//                 end;

//                 trigger OnAfterGetRecord();
//                 begin
//                     if Number > 1 then begin
//                         CopyText := Text003;
//                         OutputNo += 1;
//                     end;

//                     TotalSubTotal := 0;
//                     TotalInvoiceDiscountAmount := 0;
//                     TotalAmount := 0;
//                     TotalAmountVAT := 0;
//                     TotalAmountInclVAT := 0;
//                     TotalPaymentDiscountOnVAT := 0;
//                     TotalExciseAmt := 0;
//                     TotalTaxAmt := 0;
//                     ServiceTaxAmount := 0;
//                     ServiceTaxeCessAmount := 0;
//                     ServiceTaxSHECessAmount := 0;
//                     OtherTaxesAmount := 0;
//                     ChargesAmount := 0;
//                     AppliedServiceTaxSHECessAmt := 0;
//                     AppliedServiceTaxECessAmt := 0;
//                     AppliedServiceTaxAmt := 0;
//                     ServiceTaxSHECessAmt := 0;
//                     ServiceTaxECessAmt := 0;
//                     ServiceTaxAmt := 0;
//                     TotalTCSAmount := 0;
//                 end;

//                 trigger OnPostDataItem();
//                 begin
//                     if not CurrReport.Preview then
//                         SalesInvCountPrinted.Run("Sales Invoice Header");
//                 end;

//             }
//             trigger OnAfterGetRecord();
//             var
//                 SalesInvLine: Record "Sales Invoice Line";
//                 Location: Record Location;
//             begin
//                 CurrReport.Language := Language.GetLanguageID("Language Code");
//                 if RespCenter.Get("Responsibility Center") then begin
//                     FormatAddr.RespCenter(CompanyAddr, RespCenter);
//                     CompanyInfo."Phone No." := RespCenter."Phone No.";
//                     CompanyInfo."Fax No." := RespCenter."Fax No.";
//                 end else begin
//                     FormatAddr.Company(CompanyAddr, CompanyInfo);
//                 end;
//                 DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
//                 if "Order No." = '' then
//                     OrderNoText := ''
//                 else
//                     OrderNoText := FieldCaption("Order No.");
//                 if "Salesperson Code" = '' then begin
//                     SalesPurchPerson.Init;
//                     SalesPersonText := '';
//                 end else begin
//                     SalesPurchPerson.Get("Salesperson Code");
//                     SalesPersonText := Text000;
//                 end;
//                 if "Your Reference" = '' then
//                     ReferenceText := ''
//                 else
//                     ReferenceText := FieldCaption("Your Reference");
//                 if "VAT Registration No." = '' then
//                     VATNoText := ''
//                 else
//                     VATNoText := FieldCaption("VAT Registration No.");
//                 if "Currency Code" = '' then begin
//                     GLSetup.TestField("LCY Code");
//                     TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
//                     TotalInclVATText := StrSubstNo(Text13700, GLSetup."LCY Code");
//                     TotalExclVATText := StrSubstNo(Text13701, GLSetup."LCY Code");
//                 end else begin
//                     TotalText := StrSubstNo(Text001, "Currency Code");
//                     TotalInclVATText := StrSubstNo(Text13700, "Currency Code");
//                     TotalExclVATText := StrSubstNo(Text13701, "Currency Code");
//                 end;
//                 FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
//                 if not Cust.Get("Bill-to Customer No.") then
//                     Clear(Cust);
//                 if "Payment Terms Code" = '' then
//                     PaymentTerms.Init
//                 else begin
//                     PaymentTerms.Get("Payment Terms Code");
//                     PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
//                 end;
//                 if "Shipment Method Code" = '' then
//                     ShipmentMethod.Init
//                 else begin
//                     ShipmentMethod.Get("Shipment Method Code");
//                     ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
//                 end;
//                 FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");
//                 ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
//                 for i := 1 to ArrayLen(ShipToAddr) do
//                     if ShipToAddr[i] <> CustAddr[i] then
//                         ShowShippingAddr := true;
//                 if LogInteraction then
//                     if not CurrReport.Preview then begin
//                         if "Bill-to Contact No." <> '' then
//                             SegManagement.LogDocument(
//                               4, "No.", 0, 0, Database::Contact, "Bill-to Contact No.", "Salesperson Code",
//                               "Campaign No.", "Posting Description", '')
//                         else
//                             SegManagement.LogDocument(
//                               4, "No.", 0, 0, Database::Customer, "Bill-to Customer No.", "Salesperson Code",
//                               "Campaign No.", "Posting Description", '');
//                     end;
//                 SupplementaryText := '';
//                 SalesInvLine.SetRange("Document No.", "No.");
//                 SalesInvLine.SetRange(Supplementary, true);
//                 if SalesInvLine.Find('-') then
//                     SupplementaryText := Text16500;
//                 if Location.Get("Location Code") then
//                     ServiceTaxRegistrationNo := Location."Service Tax Registration No."
//                 else
//                     ServiceTaxRegistrationNo := CompanyInfo."Service Tax Registration No.";
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
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(NoOfCopies; NoOfCopies)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'No. of Copies';
//                     }
//                     field(ShowInternalInfo; ShowInternalInfo)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Show Internal Information';
//                     }
//                     field(LogInteraction; LogInteraction)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Log Interaction';
//                         Enabled = LogInteractionEnable;
//                     }
//                     field(DisplayAsmInformation; DisplayAssemblyInformation)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Show Assembly Components';
//                     }

//                 }
//             }
//         }

//         actions
//         {
//         }

//         trigger OnInit()
//         begin
//             LogInteractionEnable := true;
//         end;

//         trigger OnOpenPage()
//         begin
//             InitLogInteraction;
//             LogInteractionEnable := LogInteraction;
//         end;
//     }

//     trigger OnInitReport()
//     begin
//         GLSetup.Get;
//         CompanyInfo.Get;
//         SalesSetup.Get;
//         case SalesSetup."Logo Position on Documents" of
//             SalesSetup."logo position on documents"::"No Logo":
//                 ;
//             SalesSetup."logo position on documents"::Left:
//                 begin
//                     CompanyInfo3.Get;
//                     CompanyInfo3.CalcFields(Picture);
//                 end;
//             SalesSetup."logo position on documents"::Center:
//                 begin
//                     CompanyInfo1.Get;
//                     CompanyInfo1.CalcFields(Picture);
//                 end;
//             SalesSetup."logo position on documents"::Right:
//                 begin
//                     CompanyInfo2.Get;
//                     CompanyInfo2.CalcFields(Picture);
//                 end;
//         end;



//     end;


//     trigger OnPreReport()
//     begin
//         if not CurrReport.UseRequestPage then
//             InitLogInteraction;

//     end;

//     var
//         DetailGSTLedEnrty: Record "Detailed GST Ledger Entry";
//         SGSTAmount: Decimal;
//         IGSTAmount: Decimal;
//         CGSTAmount: Decimal;
//         GSTAmount: Decimal;
//         Amount_To_Cust: Decimal;
//         CustLedEntry: Record "Cust. Ledger Entry";
//         Text000: label 'Salesperson';
//         Text001: label 'Total %1';
//         Text002: label 'Total %1 Incl. VAT';
//         Text003: label ' COPY';
//         Text004: label 'Sales - Invoice%1';
//         Text005: label 'Page %1';
//         Text006: label 'Total %1 Excl. VAT';
//         GLSetup: Record "General Ledger Setup";
//         ShipmentMethod: Record "Shipment Method";
//         PaymentTerms: Record "Payment Terms";
//         SalesPurchPerson: Record "Salesperson/Purchaser";
//         CompanyInfo: Record "Company Information";
//         CompanyInfo1: Record "Company Information";
//         CompanyInfo2: Record "Company Information";
//         CompanyInfo3: Record "Company Information";
//         SalesSetup: Record "Sales & Receivables Setup";
//         Cust: Record Customer;
//         VATAmountLine: Record "VAT Amount Line" temporary;
//         DimSetEntry1: Record "Dimension Set Entry";
//         DimSetEntry2: Record "Dimension Set Entry";
//         RespCenter: Record "Responsibility Center";
//         Language: Record Language;
//         CurrExchRate: Record "Currency Exchange Rate";
//         TempPostedAsmLine: Record "Posted Assembly Line" temporary;
//         SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
//         FormatAddr: Codeunit "Format Address";
//         SegManagement: Codeunit SegManagement;
//         SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
//         PostedShipmentDate: Date;
//         CustAddr: array[8] of Text[50];
//         ShipToAddr: array[8] of Text[50];
//         CompanyAddr: array[8] of Text[50];
//         OrderNoText: Text[80];
//         SalesPersonText: Text[30];
//         VATNoText: Text[80];
//         ReferenceText: Text[80];
//         TotalText: Text[50];
//         TotalExclVATText: Text[50];
//         TotalInclVATText: Text[50];
//         MoreLines: Boolean;
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[30];
//         ShowShippingAddr: Boolean;
//         i: Integer;
//         NextEntryNo: Integer;
//         FirstValueEntryNo: Integer;
//         DimText: Text[120];
//         OldDimText: Text[75];
//         ShowInternalInfo: Boolean;
//         Continue: Boolean;
//         LogInteraction: Boolean;
//         VALVATBaseLCY: Decimal;
//         VALVATAmountLCY: Decimal;
//         VALSpecLCYHeader: Text[80];
//         Text007: label 'VAT Amount Specification in ';
//         Text008: label 'Local Currency';
//         VALExchRate: Text[50];
//         Text009: label 'Exchange rate: %1/%2';
//         CalculatedExchRate: Decimal;
//         Text010: label 'Sales - Prepayment Invoice %1';
//         OutputNo: Integer;
//         TotalSubTotal: Decimal;
//         TotalAmount: Decimal;
//         TotalAmountInclVAT: Decimal;
//         TotalAmountVAT: Decimal;
//         TotalInvoiceDiscountAmount: Decimal;
//         TotalPaymentDiscountOnVAT: Decimal;
//         ChargesAmount: Decimal;
//         OtherTaxesAmount: Decimal;
//         Text13700: label 'Total %1 Incl. Taxes';
//         Text13701: label 'Total %1 Excl. Taxes';
//         SupplementaryText: Text[30];
//         Text16500: label 'Supplementary Invoice';
//         ServiceTaxEntry: Record "Service Tax Entry";
//         ServiceTaxAmt: Decimal;
//         ServiceTaxECessAmt: Decimal;
//         AppliedServiceTaxAmt: Decimal;
//         AppliedServiceTaxECessAmt: Decimal;
//         ServiceTaxSHECessAmt: Decimal;
//         AppliedServiceTaxSHECessAmt: Decimal;
//         TotalTaxAmt: Decimal;
//         TotalExciseAmt: Decimal;
//         TotalTCSAmount: Decimal;
//         ServiceTaxAmount: Decimal;
//         ServiceTaxeCessAmount: Decimal;
//         ServiceTaxSHECessAmount: Decimal;
//         [InDataSet]
//         LogInteractionEnable: Boolean;
//         DisplayAssemblyInformation: Boolean;
//         PhoneNoCaptionLbl: label 'Phone No.';
//         HomePageCaptionLbl: label 'Home Page';
//         VATRegNoCaptionLbl: label 'VAT Registration No.';
//         GiroNoCaptionLbl: label 'Giro No.';
//         BankNameCaptionLbl: label 'Bank';
//         BankAccNoCaptionLbl: label 'Account No.';
//         DueDateCaptionLbl: label 'Due Date';
//         InvoiceNoCaptionLbl: label 'Invoice No.';
//         PostingDateCaptionLbl: label 'Posting Date';
//         PLAEntryNoCaptionLbl: label 'PLA Entry No.';
//         RG23AEntryNoCaptionLbl: label 'RG23A Entry No.';
//         RG23CEntryNoCaptionLbl: label 'RG23C Entry No.';
//         HeaderDimensionsCaptionLbl: label 'Header Dimensions';
//         UnitPriceCaptionLbl: label 'Unit Price';
//         DiscountCaptionLbl: label 'Discount %';
//         AmountCaptionLbl: label 'Amount';
//         LineDiscountCaptionLbl: label 'Line Discount Amount';
//         PostedShipmentDateCaptionLbl: label 'Posted Shipment Date';
//         SubtotalCaptionLbl: label 'Subtotal';
//         ExciseAmountCaptionLbl: label 'Excise Amount';
//         TaxAmountCaptionLbl: label 'Tax Amount';
//         ServiceTaxAmountCaptionLbl: label 'Service Tax Amount';
//         ChargesAmountCaptionLbl: label 'Charges Amount';
//         OtherTaxesAmountCaptionLbl: label 'Other Taxes Amount';
//         ServTaxeCessAmtCaptionLbl: label 'Service Tax eCess Amount';
//         TCSAmountCaptionLbl: label 'TCS Amount';
//         SvcTaxAmtAppliedCaptionLbl: label 'Svc Tax Amt (Applied)';
//         SvcTaxeCessAmtAppliedCaptionLbl: label 'Svc Tax eCess Amt (Applied)';
//         ServTaxSHECessAmtCaptionLbl: label 'Service Tax SHE Cess Amount';
//         SvcTaxSHECessAmtAppliedCaptionLbl: label 'Svc Tax SHECess Amt(Applied)';
//         PaymentDiscVATCaptionLbl: label 'Payment Discount on VAT';
//         ShipmentCaptionLbl: label 'Shipment';
//         LineDimensionsCaptionLbl: label 'Line Dimensions';
//         VATAmountSpecificationCaptionLbl: label 'VAT Amount Specification';
//         InvDiscBaseAmtCaptionLbl: label 'Invoice Discount Base Amount';
//         LineAmountCaptionLbl: label 'Line Amount';
//         ShipToAddressCaptionLbl: label 'Ship-to Address';
//         ServiceTaxRegistrationNo: Code[20];
//         ServiceTaxRegistrationNoLbl: label 'Service Tax Registration No.';
//         InvDiscountAmountCaptionLbl: label 'Invoice Discount Amount';
//         VATPercentageCaptionLbl: label 'VAT %';
//         VATAmountCaptionLbl: label 'VAT Amount';
//         VATIdentifierCaptionLbl: label 'VAT Identifier';
//         TotalCaptionLbl: label 'Total';
//         VATBaseCaptionLbl: label 'VAT Base';
//         PaymentTermsCaptionLbl: label 'Payment Terms';
//         ShipmentMethodCaptionLbl: label 'Shipment Method';
//         EMailCaptionLbl: label 'E-Mail';
//         DocumentDateCaptionLbl: label 'Document Date';

//     procedure InitLogInteraction()
//     begin
//         LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
//     end;

//     procedure FindPostedShipmentDate(): Date
//     var
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
//     begin
//         NextEntryNo := 1;
//         if "Sales Invoice Line"."Shipment No." <> '' then
//             if SalesShipmentHeader.Get("Sales Invoice Line"."Shipment No.") then
//                 exit(SalesShipmentHeader."Posting Date");
//         if "Sales Invoice Header"."Order No." = '' then
//             exit("Sales Invoice Header"."Posting Date");
//         case "Sales Invoice Line".Type of
//             "Sales Invoice Line".Type::Item:
//                 GenerateBufferFromValueEntry("Sales Invoice Line");
//             "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
//           "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
//                 GenerateBufferFromShipment("Sales Invoice Line");
//             "Sales Invoice Line".Type::" ":
//                 exit(0D);
//         end;
//         SalesShipmentBuffer.Reset;
//         SalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
//         SalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
//         if SalesShipmentBuffer.Find('-') then begin
//             SalesShipmentBuffer2 := SalesShipmentBuffer;
//             if SalesShipmentBuffer.Next = 0 then begin
//                 SalesShipmentBuffer.Get(
//                   SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
//                 SalesShipmentBuffer.Delete;
//                 exit(SalesShipmentBuffer2."Posting Date");
//             end;
//             SalesShipmentBuffer.CalcSums(Quantity);
//             if SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity then begin
//                 SalesShipmentBuffer.DeleteAll;
//                 exit("Sales Invoice Header"."Posting Date");
//             end;
//         end else
//             exit("Sales Invoice Header"."Posting Date");
//     end;

//     procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
//     var
//         ValueEntry: Record "Value Entry";
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         TotalQuantity: Decimal;
//         Quantity: Decimal;
//     begin
//         TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
//         ValueEntry.SetCurrentkey("Document No.");
//         ValueEntry.SetRange("Document No.", SalesInvoiceLine2."Document No.");
//         ValueEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
//         ValueEntry.SetRange("Item Charge No.", '');
//         ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
//         if ValueEntry.Find('-') then
//             repeat
//                 if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
//                     if SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then
//                         Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
//                     else
//                         Quantity := ValueEntry."Invoiced Quantity";
//                     AddBufferEntry(
//                       SalesInvoiceLine2,
//                       -Quantity,
//                       ItemLedgerEntry."Posting Date");
//                     TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
//                 end;
//                 FirstValueEntryNo := ValueEntry."Entry No." + 1;
//             until (ValueEntry.Next = 0) or (TotalQuantity = 0);
//     end;

//     procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
//     var
//         SalesInvoiceHeader: Record "Sales Invoice Header";
//         SalesInvoiceLine2: Record "Sales Invoice Line";
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         SalesShipmentLine: Record "Sales Shipment Line";
//         TotalQuantity: Decimal;
//         Quantity: Decimal;
//     begin
//         TotalQuantity := 0;
//         SalesInvoiceHeader.SetCurrentkey("Order No.");
//         SalesInvoiceHeader.SetFilter("No.", '..%1', "Sales Invoice Header"."No.");
//         SalesInvoiceHeader.SetRange("Order No.", "Sales Invoice Header"."Order No.");
//         if SalesInvoiceHeader.Find('-') then
//             repeat
//                 SalesInvoiceLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
//                 SalesInvoiceLine2.SetRange("Line No.", SalesInvoiceLine."Line No.");
//                 SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine.Type);
//                 SalesInvoiceLine2.SetRange("No.", SalesInvoiceLine."No.");
//                 SalesInvoiceLine2.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
//                 if SalesInvoiceLine2.Find('-') then
//                     repeat
//                         TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
//                     until SalesInvoiceLine2.Next = 0;
//             until SalesInvoiceHeader.Next = 0;
//         SalesShipmentLine.SetCurrentkey("Order No.", "Order Line No.");
//         SalesShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
//         SalesShipmentLine.SetRange("Order Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentLine.SetRange("Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentLine.SetRange(Type, SalesInvoiceLine.Type);
//         SalesShipmentLine.SetRange("No.", SalesInvoiceLine."No.");
//         SalesShipmentLine.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
//         SalesShipmentLine.SetFilter(Quantity, '<>%1', 0);
//         if SalesShipmentLine.Find('-') then
//             repeat
//                 if "Sales Invoice Header"."Get Shipment Used" then
//                     CorrectShipment(SalesShipmentLine);
//                 if Abs(SalesShipmentLine.Quantity) <= Abs(TotalQuantity - SalesInvoiceLine.Quantity) then
//                     TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
//                 else begin
//                     if Abs(SalesShipmentLine.Quantity) > Abs(TotalQuantity) then
//                         SalesShipmentLine.Quantity := TotalQuantity;
//                     Quantity :=
//                       SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);
//                     TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
//                     SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;
//                     if SalesShipmentHeader.Get(SalesShipmentLine."Document No.") then begin
//                         AddBufferEntry(
//                           SalesInvoiceLine,
//                           Quantity,
//                           SalesShipmentHeader."Posting Date");
//                     end;
//                 end;
//             until (SalesShipmentLine.Next = 0) or (TotalQuantity = 0);
//     end;

//     procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
//     var
//         SalesInvoiceLine: Record "Sales Invoice Line";
//     begin
//         SalesInvoiceLine.SetCurrentkey("Shipment No.", "Shipment Line No.");
//         SalesInvoiceLine.SetRange("Shipment No.", SalesShipmentLine."Document No.");
//         SalesInvoiceLine.SetRange("Shipment Line No.", SalesShipmentLine."Line No.");
//         if SalesInvoiceLine.Find('-') then
//             repeat
//                 SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
//             until SalesInvoiceLine.Next = 0;
//     end;

//     procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
//     begin
//         SalesShipmentBuffer.SetRange("Document No.", SalesInvoiceLine."Document No.");
//         SalesShipmentBuffer.SetRange("Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentBuffer.SetRange("Posting Date", PostingDate);
//         if SalesShipmentBuffer.Find('-') then begin
//             SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
//             SalesShipmentBuffer.Modify;
//             exit;
//         end;
//         SalesShipmentBuffer."Document No." := SalesInvoiceLine."Document No.";
//         SalesShipmentBuffer."Line No." := SalesInvoiceLine."Line No.";
//         SalesShipmentBuffer."Entry No." := NextEntryNo;
//         SalesShipmentBuffer.Type := SalesInvoiceLine.Type;
//         SalesShipmentBuffer."No." := SalesInvoiceLine."No.";
//         SalesShipmentBuffer.Quantity := QtyOnShipment;
//         SalesShipmentBuffer."Posting Date" := PostingDate;
//         SalesShipmentBuffer.Insert;
//         NextEntryNo := NextEntryNo + 1
//     end;

//     local procedure DocumentCaption(): Text[250]
//     begin
//         if "Sales Invoice Header"."Prepayment Invoice" then
//             exit(Text010);
//         exit(Text004);
//     end;

//     procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
//     begin
//         NoOfCopies := NewNoOfCopies;
//         ShowInternalInfo := NewShowInternalInfo;
//         LogInteraction := NewLogInteraction;
//         DisplayAssemblyInformation := DisplayAsmInfo;
//     end;

//     procedure CollectAsmInformation()
//     var
//         ValueEntry: Record "Value Entry";
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         PostedAsmHeader: Record "Posted Assembly Header";
//         PostedAsmLine: Record "Posted Assembly Line";
//         SalesShipmentLine: Record "Sales Shipment Line";
//     begin
//         TempPostedAsmLine.DeleteAll;
//         if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item then
//             exit;
//         ValueEntry.SetCurrentkey("Document No.");
//         ValueEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
//         ValueEntry.SetRange("Document Type", ValueEntry."document type"::"Sales Invoice");
//         ValueEntry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
//         if not ValueEntry.FindSet then
//             exit;
//         repeat
//             if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
//                 if ItemLedgerEntry."Document Type" = ItemLedgerEntry."document type"::"Sales Shipment" then begin
//                     SalesShipmentLine.Get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
//                     if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
//                         PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
//                         if PostedAsmLine.FindSet then
//                             repeat
//                                 TreatAsmLineBuffer(PostedAsmLine);
//                             until PostedAsmLine.Next = 0;
//                     end;
//                 end;
//             end;
//         until ValueEntry.Next = 0;
//     end;

//     procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
//     begin
//         Clear(TempPostedAsmLine);
//         TempPostedAsmLine.SetRange(Type, PostedAsmLine.Type);
//         TempPostedAsmLine.SetRange("No.", PostedAsmLine."No.");
//         TempPostedAsmLine.SetRange("Variant Code", PostedAsmLine."Variant Code");
//         TempPostedAsmLine.SetRange(Description, PostedAsmLine.Description);
//         TempPostedAsmLine.SetRange("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
//         if TempPostedAsmLine.FindFirst then begin
//             TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
//             TempPostedAsmLine.Modify;
//         end else begin
//             Clear(TempPostedAsmLine);
//             TempPostedAsmLine := PostedAsmLine;
//             TempPostedAsmLine.Insert;
//         end;
//     end;

//     procedure GetUOMText(UOMCode: Code[10]): Text[10]
//     var
//         UnitOfMeasure: Record "Unit of Measure";
//     begin
//         if not UnitOfMeasure.Get(UOMCode) then
//             exit(UOMCode);
//         exit(UnitOfMeasure.Description);
//     end;

//     procedure BlanksForIndent(): Text[10]
//     begin
//         exit(PadStr('', 2, ' '));
//     end;
// }