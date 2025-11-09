Report 50058 "Sale Register GST"
{
    RDLCLayout = './Layouts/SaleRegisterGST.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(PostingDate_SalesInvoiceHeader; Format("Posting Date"))
            {
            }
            column(DocType; DocType)
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(SelltoCity_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to City")
            {
            }
            column(StateName; StateName)
            {
            }
            column(CountryName; CountryName)
            {
            }
            column(PANNo; PANNo)
            {
            }
            column(GSTINNo; GSTINNo)
            {
            }
            column(HSNCode; HSNCode)
            {
            }
            column(ProductValue; ProductValue)
            {
            }
            column(SchDiscAmt; SchDiscAmt)
            {
            }
            column(TradeDiscAmt; TradeDiscAmt)
            {
            }
            column(TaxableAmt; TaxableAmt)
            {
            }
            column(IGSTAmt; IGSTAmt)
            {
            }
            column(SGSTAmt; SGSTAmt)
            {
            }
            column(CGSTAmt; CGSTAmt)
            {
            }
            column(TotalAmt; TotalAmt)
            {
            }
            column(NoOfCasesTxt; NoOfCasesTxt)
            {
            }
            column(Total_GST_Amt; IGSTAmt + SGSTAmt + CGSTAmt)
            {
            }
            column(InvoiceType; InvoiceType)
            {
            }
            column(ReportName; ReportName)
            {
            }
            trigger OnPreDataItem();
            begin
                if StartDate > 0D then
                    SetRange("Posting Date", StartDate, EndDate);
            end;

            trigger OnAfterGetRecord();
            begin
                DocType := 'Invoice';
                StateName := '';
                CountryName := '';
                PANNo := '';
                GSTINNo := '';
                PreHSN := '';
                ProductValue := 0;
                TradeDiscAmt := 0;
                SchDiscAmt := 0;
                TaxableAmt := 0;
                if CustomerRec.Get("Sales Invoice Header"."Sell-to Customer No.") then begin
                    if StateRec.Get(CustomerRec."State Code") then
                        StateName := StateRec.Description;
                    if CountryRegion.Get(CustomerRec."Country/Region Code") then
                        CountryName := CountryRegion.Name;
                    PANNo := CustomerRec."P.A.N. No.";
                    GSTINNo := CustomerRec."GST Registration No.";
                end;
                Counter := 1;
                SalesInvoiceLine.Reset;
                SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvoiceLine.SetCurrentkey("HSN/SAC Code");
                if SalesInvoiceLine.FindFirst then
                    repeat
                        if PreHSN <> SalesInvoiceLine."HSN/SAC Code" then begin
                            if Counter = 1 then
                                HSNCode := SalesInvoiceLine."HSN/SAC Code"
                            else
                                HSNCode := HSNCode + ', ' + SalesInvoiceLine."HSN/SAC Code";
                            Counter += 1;
                        end;
                        PreHSN := SalesInvoiceLine."HSN/SAC Code";
                        ProductValue := ProductValue + SalesInvoiceLine."Line Amount";
                        SchDiscAmt += SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price";//alp
                        TradeDiscAmt += SalesInvoiceLine."Inv. Discount Amount";//alp
                    until SalesInvoiceLine.Next = 0;
                TaxableAmt := ProductValue - SchDiscAmt - TradeDiscAmt;
                IGSTAmt := 0;
                CGSTAmt := 0;
                SGSTAmt := 0;
                GSTLedger.Reset;
                GSTLedger.SetRange("Transaction Type", GSTLedger."transaction type"::Sales);
                GSTLedger.SetRange(GSTLedger."Document No.", "Sales Invoice Header"."No.");
                if GSTLedger.FindFirst then
                    repeat
                        if GSTLedger."GST Component Code" = 'IGST' then
                            IGSTAmt += Abs(GSTLedger."GST Amount");
                        if GSTLedger."GST Component Code" = 'CGST' then
                            CGSTAmt += Abs(GSTLedger."GST Amount");
                        if GSTLedger."GST Component Code" = 'SGST' then
                            SGSTAmt += Abs(GSTLedger."GST Amount");
                    until GSTLedger.Next = 0;
                if (IGSTAmt + CGSTAmt + SGSTAmt) <> 0 then
                    InvoiceType := 'Tax Invoice'
                else
                    InvoiceType := 'Bill of Supply';
                TotalAmt := 0;
                TotalAmt := TaxableAmt + IGSTAmt + CGSTAmt + SGSTAmt;
                //NoOfCasesTxt := '';
                //NoOfCasesTxt :=DELCHR("Total Cases",'=',DELCHR("Total Cases",'=','1234567890'));
            end;

        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            column(Cr_Inv_No; "Sales Cr.Memo Header"."No.")
            {
            }
            column(PostingDate_CM; Format("Posting Date"))
            {
            }
            column(DocType_CM; DocType)
            {
            }
            column(SelltoCustomerName_CM; "Sales Cr.Memo Header"."Sell-to Customer Name")
            {
            }
            column(SelltoCity_CM; "Sales Cr.Memo Header"."Sell-to City")
            {
            }
            column(StateName_CM; StateName)
            {
            }
            column(CountryName_CM; CountryName)
            {
            }
            column(PANNo_CM; PANNo)
            {
            }
            column(GSTINNo_CM; GSTINNo)
            {
            }
            column(HSNCode_CM; HSNCode)
            {
            }
            column(ProductValue_CM; ProductValue)
            {
            }
            column(SchDiscAmt_CM; SchDiscAmt)
            {
            }
            column(TradeDiscAmt_CM; TradeDiscAmt)
            {
            }
            column(TaxableAmt_CM; TaxableAmt)
            {
            }
            column(IGSTAmt_CM; IGSTAmt)
            {
            }
            column(SGSTAmt_CM; SGSTAmt)
            {
            }
            column(CGSTAmt_CM; CGSTAmt)
            {
            }
            column(TotalAmt_CM; TotalAmt)
            {
            }
            column(NoOfCasesTxt_CM; NoOfCasesTxt)
            {
            }
            column(Total_GST_Amt_CM; IGSTAmt + SGSTAmt + CGSTAmt)
            {
            }
            column(InvoiceType_CM; InvoiceType)
            {
            }
            trigger OnPreDataItem();
            begin
                if StartDate > 0D then
                    SetRange("Posting Date", StartDate, EndDate);
            end;

            trigger OnAfterGetRecord();
            begin
                DocType := 'Credit Memo';
                StateName := '';
                CountryName := '';
                PANNo := '';
                GSTINNo := '';
                PreHSN := '';
                ProductValue := 0;
                TradeDiscAmt := 0;
                SchDiscAmt := 0;
                TaxableAmt := 0;
                if CustomerRec.Get("Sell-to Customer No.") then begin
                    if StateRec.Get(CustomerRec."State Code") then
                        StateName := StateRec.Description;
                    if CountryRegion.Get(CustomerRec."Country/Region Code") then
                        CountryName := CountryRegion.Name;
                    PANNo := CustomerRec."P.A.N. No.";
                    GSTINNo := CustomerRec."GST Registration No.";
                end;
                Counter := 1;
                SalesCrMemoLine.Reset;
                SalesCrMemoLine.SetRange("Document No.", "No.");
                SalesCrMemoLine.SetCurrentkey("HSN/SAC Code");
                if SalesCrMemoLine.FindFirst then
                    repeat
                        if PreHSN <> SalesCrMemoLine."HSN/SAC Code" then begin
                            if Counter = 1 then
                                HSNCode := SalesCrMemoLine."HSN/SAC Code"
                            else
                                HSNCode := HSNCode + ', ' + SalesCrMemoLine."HSN/SAC Code";
                            Counter += 1;
                        end;
                        PreHSN := SalesCrMemoLine."HSN/SAC Code";
                        ProductValue := ProductValue + SalesCrMemoLine."Line Amount";
                        SchDiscAmt += SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price";
                        TradeDiscAmt += SalesCrMemoLine."Inv. Discount Amount";
                    until SalesCrMemoLine.Next = 0;
                TaxableAmt := ProductValue - SchDiscAmt - TradeDiscAmt;
                IGSTAmt := 0;
                CGSTAmt := 0;
                SGSTAmt := 0;
                GSTLedger.Reset;
                GSTLedger.SetRange("Transaction Type", GSTLedger."transaction type"::Sales);
                GSTLedger.SetRange(GSTLedger."Document No.", "No.");
                if GSTLedger.FindFirst then
                    repeat
                        if GSTLedger."GST Component Code" = 'IGST' then
                            IGSTAmt += Abs(GSTLedger."GST Amount");
                        if GSTLedger."GST Component Code" = 'CGST' then
                            CGSTAmt += Abs(GSTLedger."GST Amount");
                        if GSTLedger."GST Component Code" = 'SGST' then
                            SGSTAmt += Abs(GSTLedger."GST Amount");
                    until GSTLedger.Next = 0;
                if (IGSTAmt + CGSTAmt + SGSTAmt) <> 0 then
                    InvoiceType := 'Tax Invoice'
                else
                    InvoiceType := 'Bill of Supply';
                TotalAmt := 0;
                TotalAmt := TaxableAmt + IGSTAmt + CGSTAmt + SGSTAmt;
                NoOfCasesTxt := '';
                //NoOfCasesTxt :=DELCHR("Total Cases",'=',DELCHR("Total Cases",'=','1234567890'));//alp
            end;

        }
    }

    requestpage
    {

        SaveValues = true;

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

            }
        }

        actions
        {
        }
    }


    trigger OnPreReport()
    begin
        CompInfo.Get;
        ReportName := 'Sale Register';

    end;

    var
        DocType: Text;
        CustomerRec: Record Customer;
        StartDate: Date;
        EndDate: Date;
        CompInfo: Record "Company Information";
        GSTLedger: Record "GST Ledger Entry";
        StateRec: Record State;
        StateName: Text;
        CountryRegion: Record "Country/Region";
        CountryName: Text;
        PANNo: Text;
        GSTINNo: Text;
        SalesInvoiceLine: Record "Sales Invoice Line";
        PreHSN: Text;
        Counter: Integer;
        HSNCode: Text;
        ProductValue: Decimal;
        SchDiscAmt: Decimal;
        TradeDiscAmt: Decimal;
        TaxableAmt: Decimal;
        IGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
        TotalAmt: Decimal;
        NoOfCasesTxt: Text;
        InvoiceType: Text;
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ReportName: Text;

}