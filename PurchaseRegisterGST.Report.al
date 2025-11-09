Report 50057 "Purchase Register GST"
{
    RDLCLayout = './Layouts/PurchaseRegisterGST.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(CompName; CompInfo.Name)
            {
            }
            column(DocumentNo; "Purch. Inv. Header"."No.")
            {
            }
            column(PostingDate; Format("Purch. Inv. Header"."Posting Date"))
            {
            }
            column(UMC; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(VendorCity; VendorCity)
            {
            }
            column(VendorState; VendorState)
            {
            }
            column(VendorCountry; VendorCountry)
            {
            }
            column(VendorPAN; VendorPAN)
            {
            }
            column(GSTINNo; GSTINNo)
            {
            }
            column(HSNCode; HSNCode)
            {
            }
            column(LineAmt; TaxableValue)
            {
            }
            column(CGSTAmt; CGSTAmt)
            {
            }
            column(SGstAmt; SGstAmt)
            {
            }
            column(IgstAmt; IgstAmt)
            {
            }
            column(LessDis; LessDis)
            {
            }
            column(LessTrade; LessTrade)
            {
            }
            column(ProductValue; ProductValue)
            {
            }
            column(ReportName; ReportName)
            {
            }
            column(AmtToVendor; TaxableValue + TotalAmt)//"Purch. Inv. Header"."Amount to Vendor")//Lk
            {
            }
            column(DocType; DocType)
            {
            }
            column(InvoiceType; InvoiceType)
            {
            }
            column(TotalAmt; TotalAmt)
            {
            }
            trigger OnPreDataItem();
            begin
                if StartDate > 0D then
                    SetRange("Purch. Inv. Header"."Posting Date", StartDate, EndDate);
            end;

            trigger OnAfterGetRecord();
            begin
                VendorName := '';
                VendorCity := '';
                VendorState := '';
                VendorCountry := '';
                VendorPAN := '';
                DocType := '';
                DocType := 'Invoice';
                Vend.Reset;
                Vend.SetRange(Vend."No.", "Purch. Inv. Header"."Buy-from Vendor No.");
                if Vend.FindFirst then begin
                    VendorName := Vend.Name;
                    VendorCity := Vend.City;
                    VendorPAN := Vend."P.A.N. No.";
                    GSTINNo := Vend."GST Registration No.";
                    if CountryRegion.Get(Vend."Country/Region Code") then
                        VendorCountry := CountryRegion.Name;
                    VarState.Reset;
                    if VarState.Get(Vend."State Code") then
                        VendorState := VarState.Description;
                end;
                LessTrade := 0;
                LessTrade := 0;
                HSNCode := '';
                ProductValue := 0;
                Counter := 1;
                PurchaseInvLine.Reset;
                PurchaseInvLine.SetRange("Document No.", "No.");
                PurchaseInvLine.SetCurrentkey("HSN/SAC Code");
                if PurchaseInvLine.FindFirst then
                    repeat
                        if PreHSN <> PurchaseInvLine."HSN/SAC Code" then begin
                            if Counter = 1 then
                                HSNCode := PurchaseInvLine."HSN/SAC Code"
                            else
                                HSNCode := HSNCode + ', ' + PurchaseInvLine."HSN/SAC Code";
                            Counter += 1;
                        end;
                        PreHSN := PurchaseInvLine."HSN/SAC Code";
                        ProductValue := ProductValue + PurchaseInvLine."Line Amount";
                        LessDis += PurchaseInvLine.Quantity * PurchaseInvLine."Unit Cost";
                        LessTrade += PurchaseInvLine."Inv. Discount Amount";
                    until PurchaseInvLine.Next = 0;
                TaxableValue := ProductValue - LessDis - LessTrade;
                IgstAmt := 0;
                CGSTAmt := 0;
                SGstAmt := 0;
                GSTLedger.Reset;
                GSTLedger.SetRange("Transaction Type", GSTLedger."transaction type"::Purchase);
                GSTLedger.SetRange(GSTLedger."Document No.", "No.");
                if GSTLedger.FindFirst then
                    repeat
                        if GSTLedger."GST Component Code" = 'IGST' then
                            IgstAmt += GSTLedger."GST Amount";
                        if GSTLedger."GST Component Code" = 'CGST' then
                            CGSTAmt += GSTLedger."GST Amount";
                        if GSTLedger."GST Component Code" = 'SGST' then
                            SGstAmt += GSTLedger."GST Amount";
                    until GSTLedger.Next = 0;
                if (IgstAmt + CGSTAmt + SGstAmt) <> 0 then
                    InvoiceType := 'Tax Invoice'
                else
                    InvoiceType := 'Bill of Supply';
                TotalAmt := 0;
                TotalAmt := IgstAmt + CGSTAmt + SGstAmt;
            end;

        }
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            column(No; "Purch. Cr. Memo Hdr."."No.")
            {
            }
            column(Date; Format("Purch. Cr. Memo Hdr."."Posting Date"))
            {
            }
            column(VendorName1; VendorName)
            {
            }
            column(VendorCity1; VendorCity)
            {
            }
            column(VendorState1; VendorState)
            {
            }
            column(VendorCountry1; VendorCountry)
            {
            }
            column(VendorPAN1; VendorPAN)
            {
            }
            column(GSTINNo1; GSTINNo)
            {
            }
            column(HSNCode1; HSNCode)
            {
            }
            column(LineAmt1; TaxableValue)
            {
            }
            column(CGSTAmt1; CGSTAmt)
            {
            }
            column(SGstAmt1; SGstAmt)
            {
            }
            column(IgstAmt1; IgstAmt)
            {
            }
            column(LessDis1; LessDis)
            {
            }
            column(LessTrade1; LessTrade)
            {
            }
            column(ProductValue1; ProductValue)
            {
            }
            column(ReportName1; ReportName)
            {
            }
            column(AmtToVendor1; TaxableValue + TotalAmt)//"Purch. Cr. Memo Hdr."."Amount to Vendor") //Lk
            {
            }
            column(DocType1; DocType)
            {
            }
            column(TotalAmt1; TotalAmt)
            {
            }
            column(InvoiceType1; InvoiceType)
            {
            }
            trigger OnAfterGetRecord();
            begin
                VendorName := '';
                VendorCity := '';
                VendorState := '';
                VendorCountry := '';
                VendorPAN := '';
                DocType := 'Credit Memo';
                Vend.Reset;
                Vend.SetRange(Vend."No.", "Purch. Cr. Memo Hdr."."Buy-from Vendor No.");
                if Vend.FindFirst then begin
                    VendorName := Vend.Name;
                    VendorCity := Vend.City;
                    VendorPAN := Vend."P.A.N. No.";
                    GSTINNo := Vend."GST Registration No.";
                    if CountryRegion.Get(Vend."Country/Region Code") then
                        VendorCountry := CountryRegion.Name;
                    VarState.Reset;
                    if VarState.Get(Vend."State Code") then
                        VendorState := VarState.Description;
                end;
                LessTrade := 0;
                LessTrade := 0;
                HSNCode := '';
                ProductValue := 0;
                Counter := 1;
                PurCrMemoLine.Reset;
                PurCrMemoLine.SetRange("Document No.", "No.");
                PurCrMemoLine.SetCurrentkey("HSN/SAC Code");
                if PurCrMemoLine.FindFirst then
                    repeat
                        if PreHSN <> PurCrMemoLine."HSN/SAC Code" then begin
                            if Counter = 1 then
                                HSNCode := PurCrMemoLine."HSN/SAC Code"
                            else
                                HSNCode := HSNCode + ', ' + PurCrMemoLine."HSN/SAC Code";
                            Counter += 1;
                        end;
                        PreHSN := PurCrMemoLine."HSN/SAC Code";
                        ProductValue := ProductValue + PurCrMemoLine."Line Amount";
                        LessDis += PurCrMemoLine.Quantity * PurCrMemoLine."Unit Cost";
                        LessTrade += PurCrMemoLine."Inv. Discount Amount";
                    until PurCrMemoLine.Next = 0;
                TaxableValue := ProductValue - LessDis - LessTrade;
                IgstAmt := 0;
                CGSTAmt := 0;
                SGstAmt := 0;
                GSTLedger.Reset;
                GSTLedger.SetRange("Transaction Type", GSTLedger."transaction type"::Purchase);
                GSTLedger.SetRange(GSTLedger."Document No.", "No.");
                if GSTLedger.FindFirst then
                    repeat
                        if GSTLedger."GST Component Code" = 'IGST' then
                            IgstAmt += Abs(GSTLedger."GST Amount");
                        if GSTLedger."GST Component Code" = 'CGST' then
                            CGSTAmt += Abs(GSTLedger."GST Amount");
                        if GSTLedger."GST Component Code" = 'SGST' then
                            SGstAmt += Abs(GSTLedger."GST Amount");
                    until GSTLedger.Next = 0;
                if (IgstAmt + CGSTAmt + SGstAmt) <> 0 then
                    InvoiceType := 'Tax Invoice'
                else
                    InvoiceType := 'Bill of Supply';
                TotalAmt := 0;
                TotalAmt := TaxableValue + IgstAmt + CGSTAmt + SGstAmt;
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; EndDate)
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
        ReportName := 'Purchase Register';

    end;

    var
        CompInfo: Record "Company Information";
        VendorName: Text;
        VendorCity: Text;
        VendorState: Text;
        VendorCountry: Text;
        VendorPAN: Text;
        Vend: Record Vendor;
        GSTINNo: Text;
        HSNCode: Text;
        CGSTAmt: Decimal;
        SGstAmt: Decimal;
        IgstAmt: Decimal;
        DetailGstLedgerEntry: Record "Detailed GST Ledger Entry";
        LessDis: Decimal;
        LessTrade: Decimal;
        ProductValue: Decimal;
        ReportName: Text;
        VarState: Record State;
        CGSTRate: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        TotalAmt: Decimal;
        TaxableValue: Decimal;
        PurchaseInvLine: Record "Purch. Inv. Line";
        StartDate: Date;
        EndDate: Date;
        GSTLedger: Record "GST Ledger Entry";
        PreHSN: Text;
        Counter: Integer;
        InvoiceType: Text;
        PurCrMemoLine: Record "Purch. Cr. Memo Line";
        DocType: Text;
        CountryRegion: Record "Country/Region";

}