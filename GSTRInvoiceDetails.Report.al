/// <summary>
/// Report GSTR Invoice Details (ID 50177).
/// </summary>
Report 50177 "GSTR Invoice Details"
{
    RDLCLayout = './Layouts/GSTRInvoiceDetails.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(Sales_CompanyGSTIN; CompanyGSTIN)
            {
            }
            column(Sales_DocumentType; DocumentType)
            {
            }
            column(Sales_DocumentNo; DocumentNo)
            {
            }
            column(Sales_PostingDate; Format(PostingDate))
            {
            }
            column(Sales_CustomerNo; CustomerNo)
            {
            }
            column(Sales_CustomerName; CustomerName)
            {
            }
            column(Sales_CustomerGSTIN; CustomerGSTIN)
            {
            }
            column(Sales_CustomerStateCode; CustomerStateCode)
            {
            }
            column(Sales_NettAmount; InvoiceNettAmount)
            {
            }
            column(Sales_BaseAmount; InvoiceBaseAmount)
            {
            }
            column(Sales_GSTAmount; InvoiceGSTAmount)
            {
            }
            column(Sales_IGSTAmount; InvoiceIGSTAmount)
            {
            }
            column(Sales_CGSTAmount; InvoiceCGSTAmount)
            {
            }
            column(Sales_SGSTAmount; InvoiceSGSTAmount)
            {
            }
            column(Sales_CESSAmount; InvoiceCESSAmount)
            {
            }
            column(Sales_Count; Format(InvoiceCount))
            {
            }
            trigger OnPreDataItem();
            begin
                SetRange("Posting Date", StartDate, EndDate);
                if LocCode <> '' then
                    SetFilter("Location Code", LocCode);
                InvoiceCount := 0;
            end;

            trigger OnAfterGetRecord();
            begin
                InvoiceCount := InvoiceCount + 1;
                InvoiceBaseAmount := 0;
                InvoiceGSTAmount := 0;
                InvoiceIGSTAmount := 0;
                InvoiceCGSTAmount := 0;
                InvoiceSGSTAmount := 0;
                InvoiceCESSAmount := 0;
                InvoiceNettAmount := 0;
                LocRec.Get("Location Code");
                CompanyGSTIN := LocRec."GST Registration No.";
                DocumentType := 'Sales Invoice';
                DocumentNo := "No.";
                PostingDate := "Posting Date";
                CustomerNo := "Sell-to Customer No.";
                CustomerName := "Sell-to Customer Name";
                CustomerStateCode := "GST Bill-to State Code";
                Cust.Get("Sell-to Customer No.");
                CustomerGSTIN := Cust."GST Registration No.";
                CurrFactor := "Currency Factor";
                if CurrFactor = 0 then
                    CurrFactor := 1;
                DetailedGSTLedgerEntry.Reset;
                DetailedGSTLedgerEntry.SetCurrentkey("Transaction Type", "Document Type", "Document No.");
                DetailedGSTLedgerEntry.SetFilter("Location Code", "Location Code");
                DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."entry type"::"Initial Entry");
                DetailedGSTLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."transaction type"::Sales);
                DetailedGSTLedgerEntry.SetRange("Document No.", "No.");
                if DetailedGSTLedgerEntry.FindSet then
                    repeat
                        InvoiceGSTAmount := InvoiceGSTAmount - DetailedGSTLedgerEntry."GST Amount";
                        if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                            InvoiceIGSTAmount := InvoiceIGSTAmount - DetailedGSTLedgerEntry."GST Amount";
                            InvoiceBaseAmount := InvoiceBaseAmount - DetailedGSTLedgerEntry."GST Base Amount";
                        end;
                        if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                            InvoiceCGSTAmount := InvoiceCGSTAmount - DetailedGSTLedgerEntry."GST Amount";
                            InvoiceBaseAmount := InvoiceBaseAmount - DetailedGSTLedgerEntry."GST Base Amount";
                        end;
                        if (DetailedGSTLedgerEntry."GST Component Code" = 'SGST') or (DetailedGSTLedgerEntry."GST Component Code" = 'UTGST') then begin
                            InvoiceSGSTAmount := InvoiceSGSTAmount - DetailedGSTLedgerEntry."GST Amount";
                        end;
                        if DetailedGSTLedgerEntry."GST Component Code" = 'Cess' then
                            InvoiceCESSAmount := InvoiceCESSAmount - DetailedGSTLedgerEntry."GST Amount";
                    until DetailedGSTLedgerEntry.Next = 0;
                SalesInvLine.Reset;
                SalesInvLine.SetRange("Document No.", "No.");
                SalesInvLine.SetRange("Posting Date", StartDate, EndDate);
                SalesInvLine.CalcSums("Line Amount", "Inv. Discount Amount");
                InvoiceBaseAmount := (SalesInvLine."Line Amount" - SalesInvLine."Inv. Discount Amount") / CurrFactor;
                ExpChargeAmount := 0;
                ExpChargeFilter := 'AIRFRT|INS|SHIPCHG|SHIPFRT|FREIGHT';
                if Cust."Country/Region Code" <> '91' then begin
                    /* StrLineDetails.Reset;
                    StrLineDetails.SetRange("Invoice No.", "No.");
                    StrLineDetails.SetRange(Type, StrLineDetails.Type::Sale);
                    StrLineDetails.SetFilter("Tax/Charge Group", ExpChargeFilter);
                    StrLineDetails.SetFilter("Tax/Charge Type", '<>%1', StrLineDetails."tax/charge type"::GST);
                    StrLineDetails.CalcSums(Amount, "Amount (LCY)");
                    ExpChargeAmount := StrLineDetails."Amount (LCY)"; */ //LK (Table missing)
                end;
                /*  StrLineDetails.Reset;
                 StrLineDetails.SetRange("Invoice No.", "No.");
                 StrLineDetails.SetRange(Type, StrLineDetails.Type::Sale);
                 StrLineDetails.SetFilter("Tax/Charge Type", '<>%1', StrLineDetails."tax/charge type"::GST);
                 StrLineDetails.CalcSums(Amount, "Amount (LCY)");
                 InvoiceBaseAmount := InvoiceBaseAmount + StrLineDetails."Amount (LCY)"; *///LK (Table missing)
                InvoiceNettAmount := InvoiceBaseAmount + InvoiceGSTAmount;
                InvoiceBaseAmount := InvoiceBaseAmount - ExpChargeAmount;
            end;

        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            column(Return_CompanyGSTIN; CompanyGSTIN)
            {
            }
            column(Return_DocumentType; DocumentType)
            {
            }
            column(Return_DocumentNo; DocumentNo)
            {
            }
            column(Return_PostingDate; Format(PostingDate))
            {
            }
            column(Return_CustomerNo; CustomerNo)
            {
            }
            column(Return_CustomerName; CustomerName)
            {
            }
            column(Return_CustomerGSTIN; CustomerGSTIN)
            {
            }
            column(Return_CustomerStateCode; CustomerStateCode)
            {
            }
            column(Return_NettAmount; -InvoiceNettAmount)
            {
            }
            column(Return_BaseAmount; -InvoiceBaseAmount)
            {
            }
            column(Return_GSTAmount; -InvoiceGSTAmount)
            {
            }
            column(Return_IGSTAmount; -InvoiceIGSTAmount)
            {
            }
            column(Return_CGSTAmount; -InvoiceCGSTAmount)
            {
            }
            column(Return_SGSTAmount; -InvoiceSGSTAmount)
            {
            }
            column(Return_CESSAmount; -InvoiceCESSAmount)
            {
            }
            column(Return_Count; Format(InvoiceCount))
            {
            }
            trigger OnPreDataItem();
            begin
                SetRange("Posting Date", StartDate, EndDate);
                if LocCode <> '' then
                    SetFilter("Location Code", LocCode);
                InvoiceCount := 0;
            end;

            trigger OnAfterGetRecord();
            begin
                InvoiceCount := InvoiceCount + 1;
                InvoiceBaseAmount := 0;
                InvoiceGSTAmount := 0;
                InvoiceIGSTAmount := 0;
                InvoiceCGSTAmount := 0;
                InvoiceSGSTAmount := 0;
                InvoiceCESSAmount := 0;
                InvoiceNettAmount := 0;
                LocRec.Get("Location Code");
                CompanyGSTIN := LocRec."GST Registration No.";
                DocumentType := 'Sales Return';
                DocumentNo := "No.";
                PostingDate := "Posting Date";
                CustomerNo := "Sell-to Customer No.";
                CustomerName := "Sell-to Customer Name";
                CustomerStateCode := "GST Bill-to State Code";
                Cust.Get("Sell-to Customer No.");
                CustomerGSTIN := Cust."GST Registration No.";
                CurrFactor := "Currency Factor";
                if CurrFactor = 0 then
                    CurrFactor := 1;
                DetailedGSTLedgerEntry.Reset;
                DetailedGSTLedgerEntry.SetCurrentkey("Transaction Type", "Document Type", "Document No.");
                DetailedGSTLedgerEntry.SetFilter("Location Code", "Location Code");
                DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."entry type"::"Initial Entry");
                DetailedGSTLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."transaction type"::Sales);
                DetailedGSTLedgerEntry.SetRange("Document No.", "No.");
                if DetailedGSTLedgerEntry.FindSet then
                    repeat
                        InvoiceGSTAmount := InvoiceGSTAmount + DetailedGSTLedgerEntry."GST Amount";
                        if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                            InvoiceIGSTAmount := InvoiceIGSTAmount + DetailedGSTLedgerEntry."GST Amount";
                            InvoiceBaseAmount := InvoiceBaseAmount + DetailedGSTLedgerEntry."GST Base Amount";
                        end;
                        if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                            InvoiceCGSTAmount := InvoiceCGSTAmount + DetailedGSTLedgerEntry."GST Amount";
                            InvoiceBaseAmount := InvoiceBaseAmount + DetailedGSTLedgerEntry."GST Base Amount";
                        end;
                        if (DetailedGSTLedgerEntry."GST Component Code" = 'SGST') or (DetailedGSTLedgerEntry."GST Component Code" = 'UTGST') then begin
                            InvoiceSGSTAmount := InvoiceSGSTAmount + DetailedGSTLedgerEntry."GST Amount";
                        end;
                        if DetailedGSTLedgerEntry."GST Component Code" = 'Cess' then
                            InvoiceCESSAmount := InvoiceCESSAmount + DetailedGSTLedgerEntry."GST Amount";
                    until DetailedGSTLedgerEntry.Next = 0;
                SalesCrMemoLine.Reset;
                SalesCrMemoLine.SetRange("Document No.", "No.");
                SalesCrMemoLine.CalcSums("Line Amount", "Inv. Discount Amount");
                ExpChargeAmount := 0;
                ExpChargeFilter := 'AIRFRT|INS|SHIPCHG|SHIPFRT|FREIGHT';
                if Cust."Country/Region Code" <> '91' then begin
                    /*  StrLineDetails.Reset;
                     StrLineDetails.SetRange("Invoice No.", "No.");
                     StrLineDetails.SetRange(Type, StrLineDetails.Type::Sale);
                     StrLineDetails.SetFilter("Tax/Charge Group", ExpChargeFilter);
                     StrLineDetails.SetFilter("Tax/Charge Type", '<>%1', StrLineDetails."tax/charge type"::GST);
                     StrLineDetails.CalcSums(Amount, "Amount (LCY)");
                     ExpChargeAmount := StrLineDetails."Amount (LCY)"; */
                end;
                /*    StrLineDetails.Reset;
                   StrLineDetails.SetRange("Invoice No.", "No.");
                   StrLineDetails.SetRange(Type, StrLineDetails.Type::Sale);
                   StrLineDetails.SetFilter("Tax/Charge Type", '<>%1', StrLineDetails."tax/charge type"::GST);
                   StrLineDetails.CalcSums(Amount, "Amount (LCY)"); 
                   InvoiceBaseAmount := ((SalesCrMemoLine."Line Amount" - SalesCrMemoLine."Inv. Discount Amount") / CurrFactor) + StrLineDetails."Amount (LCY)";*/ //LK (Table missing)
                InvoiceNettAmount := InvoiceBaseAmount + InvoiceGSTAmount;
                InvoiceBaseAmount := InvoiceBaseAmount - ExpChargeAmount;
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = Basic;
                }
                field("GSTN No"; InputGSTINNo)
                {
                    ApplicationArea = Basic;
                    TableRelation = "GST Registration Nos.".Code;
                }

            }
        }

        actions
        {
        }
    }



    trigger OnPreReport()
    begin
        LocCode := '';
        LocRec.Reset;
        if InputGSTINNo <> '' then
            LocRec.SetRange("GST Registration No.", InputGSTINNo);
        if LocRec.FindFirst then
            repeat
                if LocCode = '' then
                    LocCode := LocRec.Code
                else
                    LocCode := LocCode + '|' + LocRec.Code;
            until LocRec.Next = 0;

    end;

    var
        StartDate: Date;
        EndDate: Date;
        InputGSTINNo: Text;
        LocCode: Text;
        Cust: Record Customer;
        LocRec: Record Location;
        CompanyGSTIN: Text;
        DocumentType: Text;
        DocumentNo: Text;
        PostingDate: Date;
        CustomerNo: Text;
        CustomerName: Text;
        CustomerGSTIN: Text;
        CustomerStateCode: Text;
        InvoiceNettAmount: Decimal;
        InvoiceBaseAmount: Decimal;
        InvoiceGSTAmount: Decimal;
        InvoiceIGSTAmount: Decimal;
        InvoiceCGSTAmount: Decimal;
        InvoiceSGSTAmount: Decimal;
        InvoiceCESSAmount: Decimal;
        InvoiceCount: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CurrFactor: Decimal;
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ExpChargeAmount: Decimal;
        ExpChargeFilter: Text;
    // StrLineDetails: Record "Posted Str Order Line Details";

}