Table 50000 PDC
{
    DrillDownPageID = "PDC List";
    LookupPageID = "PDC List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Document No."; Code[100])
        {
            Editable = false;
        }
        field(3; "PDC Type"; Option)
        {
            OptionCaption = 'Fully Filled,Blank';
            OptionMembers = "Fully Filled",Blank;
        }
        field(4; "Res Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(5; "Account Type"; Option)
        {
            Description = 'Vendor/Customer';
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(6; "Account No."; Code[20])
        {
            TableRelation = if ("Account Type" = const(Vendor)) Vendor."No."
            else
            if ("Account Type" = const(Customer)) Customer."No.";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::Vendor then begin
                    Vend.Get("Account No.");
                    Name := Vend.Name;
                end else begin
                    Cust.Get("Account No.");
                    Name := Cust.Name;
                    "Branch Code" := Cust."Global Dimension 1 Code";
                end;
            end;
        }
        field(7; Name; Text[50])
        {
            Editable = false;
        }
        field(8; "PDC Received Date"; Date)
        {

            trigger OnValidate()
            begin
                if "PDC Received Date" = 0D then
                    Error(Text007);
            end;
        }
        field(9; "PDC Cheque Date"; Date)
        {

            trigger OnValidate()
            begin
                TestField("PDC Status", "pdc status"::Open);
            end;
        }
        field(10; "PDC Cheque No."; Code[10])
        {

            trigger OnValidate()
            begin
                TestField("PDC Status", "pdc status"::Open);

                if "PDC Cheque No." <> '' then begin
                    GLSetup.Get;
                    if GLSetup."Cheque No. Length" <> 0 then
                        if StrLen("PDC Cheque No.") <> GLSetup."Cheque No. Length" then
                            Error(Text002, GLSetup."Cheque No. Length");
                end;

                "Applies-to ID" := "PDC Cheque No.";
            end;
        }
        field(11; "PDC Amount"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                //TestStatusOpen;
                if not "Sent to Bank" then
                    TestStatusOpen;

                TestField("PDC Status", "pdc status"::Open);
                TestField("PDC Type", "pdc type"::"Fully Filled");

                if ("PDC Amount" <> xRec."PDC Amount") and (xRec."PDC Amount" <> 0) then begin
                    PDCAppln.Reset;
                    PDCAppln.SetRange(PDCAppln."PDC Entry No.", "Entry No.");
                    if PDCAppln.Find('-') then begin
                        if Confirm(Text004) then begin
                            PDCAppln.DeleteAll;
                        end else begin
                            Error(Text005);
                        end;
                    end;
                end;
            end;
        }
        field(12; "PDC Not Over Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                TestField("PDC Type", "pdc type"::Blank);
            end;
        }
        field(13; "MICR Code"; Code[10])
        {
            TableRelation = "MICR Codes"."MICR Code" where("Code Type" = const(MICR));
            ValidateTableRelation = true;

            trigger OnValidate()
            begin
                if "MICR Code" = '' then exit;

                GLSetup.Get;
                if GLSetup."MICR Code Length" <> 0 then
                    if StrLen("MICR Code") <> GLSetup."MICR Code Length" then
                        Error(Text002, GLSetup."MICR Code Length");

                if MICR.Get(MICR."code type"::MICR, "MICR Code") then begin
                    "Bank No." := MICR."Bank No.";
                    "Bank Name" := MICR."Bank Name";
                    "Bank Branch" := MICR."Bank Branch";
                    "MICR Code City" := MICR."Branch City";
                end else begin
                    Error('MICR code not available');
                end;

                "Applies-to ID" := "MICR Code" + '-' + "PDC Cheque No.";
            end;
        }
        field(14; "Bank No."; Code[20])
        {
            Caption = 'Bank Drawn/Deposit Code';

            trigger OnValidate()
            begin
                TestField("Account Type", "account type"::Vendor);
            end;
        }
        field(15; "Bank Name"; Text[250])
        {
            Editable = true;
        }
        field(16; "Bank Branch"; Text[250])
        {
            Editable = true;
        }
        field(17; "Bank Deposit Code"; Code[10])
        {
            TableRelation = "MICR Codes"."MICR Code" where("Code Type" = const(BankDeposit));

            trigger OnValidate()
            var
                BankDepCode: Record "MICR Codes";
            begin
                if "Bank Deposit Code" <> '' then begin
                    //TESTFIELD("Account Type","Account Type"::Customer);
                    BankDepCode.Get(BankDepCode."code type"::BankDeposit, "Bank Deposit Code");
                    BankDepCode.TestField(BankDepCode."Bank No.");
                    "Bank No." := BankDepCode."Bank No.";
                end else begin
                    "Bank No." := '';
                end;
            end;
        }
        field(18; "PDC Deposit Date"; Date)
        {
        }
        field(19; "Bank Send Date"; Date)
        {
        }
        field(20; "PDC Status"; Option)
        {
            OptionCaption = 'Open,Posted,PaySlip Generated';
            OptionMembers = Open,Posted,"PaySlip Generated";
        }
        field(21; "Applies-to ID"; Code[20])
        {
            Editable = false;
        }
        field(22; "PDC Amount Applied"; Decimal)
        {
            CalcFormula = sum("PDC Application Entry"."Amount to Apply" where("PDC Entry No." = field("Entry No.")));
            FieldClass = FlowField;
        }
        field(23; "PDC Deposited"; Boolean)
        {
        }
        field(24; "PDC Accepted By"; Code[20])
        {
            Editable = false;
        }
        field(25; "PDC Applied By"; Code[20])
        {
            Editable = false;
        }
        field(26; "PDC Pay Slip Generated By"; Code[10])
        {
        }
        field(27; "PDC Posted By"; Code[20])
        {
            Editable = false;
        }
        field(28; "Pay Slip No."; Code[20])
        {
        }
        field(29; "Cover Checked"; Boolean)
        {
        }
        field(30; "Saved File"; Text[250])
        {
        }
        field(31; "Sent to Bank"; Boolean)
        {
            Editable = true;
        }
        field(32; "Bank deposit date"; Date)
        {
        }
        field(33; "MICR Code City"; Text[30])
        {
        }
        field(34; PDC_Status; Boolean)
        {
        }
        field(35; Update; Boolean)
        {
        }
        field(36; "Branch Code"; Text[20])
        {
        }
        field(64; "Cheque Singnature"; Boolean)
        {
        }
        field(65; "External Document No."; Code[20])
        {
        }
        field(66; "Currency Code"; Code[20])
        {
            TableRelation = Currency;
        }
        field(67; "Cheque Print Name"; Text[70])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "PDC Cheque Date", "PDC Status", "Res Center", "Account Type", "Account No.")
        {
            SumIndexFields = "PDC Amount";
        }
        key(Key3; "PDC Cheque Date", "Account Type", "Account No.")
        {
        }
        key(Key4; "Sent to Bank", "PDC Deposited", "Account No.")
        {
            SumIndexFields = "PDC Amount";
        }
        key(Key5; "PDC Status", "Account No.", "Sent to Bank")
        {
            SumIndexFields = "PDC Amount";
        }
        key(Key6; "Bank Deposit Code", "PDC Cheque Date")
        {
            SumIndexFields = "PDC Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("Sent to Bank", false);
    end;

    trigger OnModify()
    begin
        TestField("Sent to Bank", false);
    end;

    var
        MICR: Record "MICR Codes";
        GLSetup: Record "General Ledger Setup";
        Cust: Record Customer;
        Vend: Record Vendor;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PDCAppln: Record "PDC Application Entry";
        PDCStatus: Option Open,Released;
        Text001: label 'Please enter the details for MIRC Code %1';
        Text002: label 'The MICR code must have %1 characters. Please check.';
        Text003: label 'You have not selected any transactions to apply. ';
        Text004: label 'This PDC Cheque is already applied. If you change the amount, all the application entries will be deleted and you will need to reapply. Do you want to continue?';
        Text005: label 'PDC Amount is not changed. Please press Escape.';
        Text006: label 'This will delete all the applications for this Cheque.\\ You can also unapply single application entry through Apply button. \\ Do you want to Unapply this cheque completely?';
        Text007: label 'Please do not keep the PDC Received Date blank.';
        VenLedgerEntry: Record "Vendor Ledger Entry";
        recPDC: Record PDC;


    procedure FillBuffer()
    var
        PDCApplnBuffer: Record "PDC Application Buffer";
        PDCAppln: Record "PDC Application Entry";
        PDCApplnForm: Page "PDC Application Entry";
        PDCApplnBufferForm: Page "PDC Application Buffer";
        PDCAvlblAmnt: Decimal;
    begin
        CalcFields("PDC Amount Applied");

        if "PDC Amount" = 0 then
            exit;

        Message('Please click OK button after selecting the entries.');

        PDCAvlblAmnt := "PDC Amount" - "PDC Amount Applied";
        if PDCAvlblAmnt = 0 then begin
            PDCAppln.Reset;
            PDCAppln.SetRange(PDCAppln."PDC Entry No.", "Entry No.");
            PDCAppln.Find('-');
            Clear(PDCApplnForm);
            PDCApplnForm.SetTableview(PDCAppln);
            Message('This PDC is completely applied. Please check the application entries.');
            PDCApplnForm.RunModal;
            exit;
        end;

        PDCApplnBuffer.LockTable;
        PDCApplnBuffer.Reset;
        PDCApplnBuffer.SetRange(PDCApplnBuffer."PDC Entry No.", "Entry No.");
        PDCApplnBuffer.DeleteAll;
        if "Account Type" = "account type"::Customer then begin
            // CustLedgerEntry.RESET;

            CustLedgerEntry.Reset;
            CustLedgerEntry.SetRange("Customer No.", "Account No.");
            CustLedgerEntry.SetRange(Positive, true);
            CustLedgerEntry.SetRange(Open, true);
            if CustLedgerEntry.Find('-') then
                repeat
                    CustLedgerEntry.CalcFields(Amount, "Remaining Amount", "PDC Unposted Amount");
                    if CustLedgerEntry."Remaining Amount" > CustLedgerEntry."PDC Unposted Amount" then begin
                        PDCApplnBuffer.Init;
                        PDCApplnBuffer."PDC Entry No." := "Entry No.";
                        PDCApplnBuffer."Cust Ledger Entry No." := CustLedgerEntry."Entry No.";
#pragma warning disable AL0603
                        PDCApplnBuffer."Document Type" := CustLedgerEntry."Document Type";
#pragma warning restore AL0603
                        PDCApplnBuffer."Document No." := CustLedgerEntry."Document No.";
                        PDCApplnBuffer."Document Date" := CustLedgerEntry."Posting Date";
                        PDCApplnBuffer."Due Date" := CustLedgerEntry."Due Date";
                        PDCApplnBuffer."Customer No." := CustLedgerEntry."Customer No.";
                        if Cust.Get(CustLedgerEntry."Customer No.") then
                            PDCApplnBuffer."Customer Name" := Cust.Name;
                        PDCApplnBuffer."Document Amount" := CustLedgerEntry.Amount;
                        PDCApplnBuffer."Remaining Amount" := CustLedgerEntry."Remaining Amount";
                        PDCApplnBuffer."PDC Unposted Amount" := CustLedgerEntry."PDC Unposted Amount";
                        PDCApplnBuffer."Amount Available for Appln" := CustLedgerEntry."Remaining Amount" - CustLedgerEntry."PDC Unposted Amount";
                        PDCApplnBuffer."PDC Amount Available" := PDCAvlblAmnt;
                        PDCApplnBuffer.Insert;
                    end;
                until CustLedgerEntry.Next = 0;
        end
        else
            if "Account Type" = "account type"::Vendor then begin
                VenLedgerEntry.Reset;
                VenLedgerEntry.SetRange("Vendor No.", "Account No.");
                VenLedgerEntry.SetRange(Positive, false);
                VenLedgerEntry.SetRange(Open, true);
                if VenLedgerEntry.Find('-') then
                    repeat

                        VenLedgerEntry.CalcFields(Amount, "Remaining Amount", "PDC Unposted Amount");
                        if -(VenLedgerEntry."Remaining Amount") > VenLedgerEntry."PDC Unposted Amount" then begin
                            PDCApplnBuffer.Init;
                            PDCApplnBuffer."PDC Entry No." := "Entry No.";
                            PDCApplnBuffer."Account Type" := "Account Type";
                            PDCApplnBuffer."Cust Ledger Entry No." := VenLedgerEntry."Entry No.";
#pragma warning disable AL0603
                            PDCApplnBuffer."Document Type" := VenLedgerEntry."Document Type";
#pragma warning restore AL0603
                            PDCApplnBuffer."Document No." := VenLedgerEntry."Document No.";
                            PDCApplnBuffer."Document Date" := VenLedgerEntry."Posting Date";
                            PDCApplnBuffer."Due Date" := VenLedgerEntry."Due Date";
                            PDCApplnBuffer."Customer No." := VenLedgerEntry."Vendor No.";
                            PDCApplnBuffer."Document Amount" := VenLedgerEntry.Amount;
                            PDCApplnBuffer."Remaining Amount" := VenLedgerEntry."Remaining Amount";
                            //PDCApplnBuffer."External Document No.":=VendLedgerEntry."External Document No.";
                            PDCApplnBuffer."PDC Unposted Amount" := VenLedgerEntry."PDC Unposted Amount";
                            PDCApplnBuffer."Amount Available for Appln" := VenLedgerEntry."Remaining Amount" -
                            VenLedgerEntry."PDC Unposted Amount";
                            PDCApplnBuffer."PDC Amount Available" := PDCAvlblAmnt;
                            PDCApplnBuffer.Insert;
                        end;
                    until VenLedgerEntry.Next = 0;
            end;

        //Check For Customer/Vendor --


        if PDCApplnBuffer.IsEmpty then begin
            Message('There are no transactions for application.');
            exit;
            //  PDCAppln.RESET;
            //  PDCAppln.SETRANGE("PDC Entry No.","Entry No.");
            //  IF PDCAppln.FINDSET THEN
        end;

        Commit;

        Clear(PDCApplnBufferForm);
        PDCApplnBufferForm.SetTableview(PDCApplnBuffer);
        //PDCApplnBufferForm.LOOKUPMODE := TRUE;

        if PDCApplnBufferForm.RunModal in [Action::OK, Action::LookupOK] then begin
            if "Account Type" = "account type"::Customer then
                PDCApplnBuffer.SetFilter(PDCApplnBuffer."Amount to Apply", '>0')
            else
                if "Account Type" = "account type"::Vendor then
                    PDCApplnBuffer.SetFilter(PDCApplnBuffer."Amount to Apply", '<0');

            if PDCApplnBuffer.Find('-') then begin
                PDCAppln.LockTable;
                repeat
                    if PDCAppln.Get(PDCApplnBuffer."PDC Entry No.", PDCApplnBuffer."Cust Ledger Entry No.") then begin
                        PDCAppln."Amount to Apply" += PDCApplnBuffer."Amount to Apply";
                        PDCAppln.Modify;
                    end else begin
                        PDCAppln.Init;
                        PDCAppln."PDC Entry No." := PDCApplnBuffer."PDC Entry No.";
                        PDCAppln."Cust Ledger Entry No." := PDCApplnBuffer."Cust Ledger Entry No.";
                        PDCAppln."Amount to Apply" := PDCApplnBuffer."Amount to Apply";
                        PDCAppln."Customer No." := PDCApplnBuffer."Customer No.";
                        if Cust.Get(CustLedgerEntry."Customer No.") then
                            PDCApplnBuffer."Customer Name" := Cust.Name;
                        PDCAppln."Document Type" := PDCApplnBuffer."Document Type";
                        PDCAppln."Document No." := PDCApplnBuffer."Document No.";
                        PDCAppln."Document Date" := PDCApplnBuffer."Document Date";
                        PDCAppln."Due Date" := PDCApplnBuffer."Due Date";
                        PDCAppln.Insert;
                    end;
                until PDCApplnBuffer.Next = 0;
                "PDC Applied By" := UserId;
            end else begin
                PDCApplnBuffer.SetRange(PDCApplnBuffer.Apply, true);
                PDCApplnBuffer.DeleteAll;
                Error(Text003);
            end;
        end else begin
            PDCApplnBuffer.Reset;
            PDCApplnBuffer.SetRange(PDCApplnBuffer."PDC Entry No.", "Entry No.");
            PDCApplnBuffer.DeleteAll;
        end;
    end;


    procedure DelAppln()
    begin
        if not Confirm(Text006) then
            exit;

        PDCAppln.Reset;
        PDCAppln.SetRange(PDCAppln."PDC Entry No.", "Entry No.");
        if PDCAppln.Find('-') then
            PDCAppln.DeleteAll;
    end;


    procedure PDCStatusupdate(): Text[30]
    begin

        if PDC_Status then
            exit('Released')
        else
            exit('Open');
    end;


    procedure TestStatusOpen()
    begin
        if PDC_Status then
            Error('You can not modify the PDC as PDC status is released.');
    end;
}

