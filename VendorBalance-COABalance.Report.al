Report 50167 "Vendor Balance - COA Balance"
{
    Permissions = TableData "G/L Entry" = rm, TableData "Vendor Ledger Entry" = rm;
    RDLCLayout = './Layouts/VendorBalance-COABalance.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Vendor Posting Group"; "Vendor Posting Group")
        {
            DataItemTableView = sorting(Code);
            column(Code_VendorPostingGroup; "Vendor Posting Group".Code)
            {
            }
            column(PayablesAccount; "Vendor Posting Group"."Payables Account")
            {
            }
            column(COAAmountVendor; COAAmountVendor)
            {
            }
            column(VendorBalance; VendorBalance)
            {
            }
            trigger OnPreDataItem();
            begin
                //SETRANGE("Vendor Posting Group".Code,'STAFF ACC');
                if UpdatePosGrp then begin
                    GlEntry.Reset;
                    GlEntry.SetRange(GlEntry."G/L Account No.", '100301', '100308');
                    if GlEntry.FindFirst then
                        repeat
                            VendorLedgerEntry.Reset;
                            VendorLedgerEntry.SetRange(VendorLedgerEntry."Document No.", GlEntry."Document No.");
                            if VendorLedgerEntry.FindFirst then begin
                                Vendor.Get(VendorLedgerEntry."Vendor No.");
                                VendorLedgerEntry."Vendor Posting Group" := Vendor."Vendor Posting Group";
                                VendorLedgerEntry.Modify;
                                VendorPostingGroup.Get(Vendor."Vendor Posting Group");
                                GlEntry."G/L Account No." := VendorPostingGroup."Payables Account";
                                GlEntry.Modify;
                            end;
                        until GlEntry.Next = 0;
                end;
            end;

            trigger OnAfterGetRecord();
            begin
                GlEntry.Reset;
                COAAmountVendor := 0;
                GlEntry.SetRange(GlEntry."G/L Account No.", "Vendor Posting Group"."Payables Account");
                GlEntry.SetRange(GlEntry."System-Created Entry", true);
                if EDate > 0D then
                    GlEntry.SetRange(GlEntry."Posting Date", 0D, EDate);
                GlEntry.CalcSums(GlEntry.Amount);
                COAAmountVendor := GlEntry.Amount;
                VendorBalance := 0;
                Vendor.Reset;
                Vendor.SetRange(Vendor."Vendor Posting Group", "Vendor Posting Group".Code);
                if EDate > 0D then
                    Vendor.SetRange(Vendor."Date Filter", 0D, EDate);
                if Vendor.FindFirst then
                    repeat
                        Vendor.CalcFields(Vendor."Net Change (LCY)");
                        VendorBalance += Vendor."Net Change (LCY)";
                    until Vendor.Next = 0;
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
                group(Filters)
                {
                    field("As on Date"; EDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Update Posting Group"; UpdatePosGrp)
                    {
                        ApplicationArea = Basic;
                    }

                }
            }
        }

        actions
        {
        }
    }



    var
        GlEntry: Record "G/L Entry";
        EDate: Date;
        CustomerBalance: Decimal;
        Vendor: Record Vendor;
        VendorBalance: Decimal;
        COAAmountVendor: Decimal;
        UpdatePosGrp: Boolean;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorPostingGroup: Record "Vendor Posting Group";

}