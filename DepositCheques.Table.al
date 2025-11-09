Table 50004 "Deposit Cheques"
{
    // +-----------------------------------------------------------------------------------------------------------------------+
    // | Consultant            Date       Code Mark    Issue Id          Description                                           |
    // +-----------------------------------------------------------------------------------------------------------------------+
    // | Mahesh Mukundan       26-AUG-11  001          WINSPIRE.01       Modified the object.                                  |
    // +-----------------------------------------------------------------------------------------------------------------------+

    Permissions = TableData "Cust. Ledger Entry" = rimd,
                  TableData "Vendor Ledger Entry" = rimd;

    fields
    {
        field(1; "Cheque Type"; Option)
        {
            OptionMembers = PDC,Current;
        }
        field(2; "Entry No."; Integer)
        {
            BlankZero = true;
            NotBlank = true;
        }
        field(3; "Bank No."; Code[20])
        {
            Editable = false;
            TableRelation = "Bank Account";
        }
        field(4; "Res Center"; Code[10])
        {
        }
        field(5; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(6; "Cheque No."; Code[10])
        {
        }
        field(7; "Cheque Date"; Date)
        {
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "MICR Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if "MICR Code" <> '' then begin
                    if "MICR Code" <> xRec."MICR Code" then begin
                        if MICRBankDepCode.Get(MICRBankDepCode."code type"::MICR, "MICR Code") then begin
                            "Issued Bank Name" := MICRBankDepCode."Bank Name";
                            "Issued Bank Branch" := MICRBankDepCode."Bank Branch";
                        end;
                    end;
                end;
            end;
        }
        field(10; "Issued Bank Name"; Text[250])
        {
        }
        field(11; "Issued Bank Branch"; Text[250])
        {
        }
        field(12; "Bank Deposit Code"; Code[10])
        {
            TableRelation = "MICR Codes"."MICR Code" where("Code Type" = const(BankDeposit));

            trigger OnValidate()
            begin
                if "Bank Deposit Code" <> '' then begin
                    MICRBankDepCode.Get(MICRBankDepCode."code type"::BankDeposit, "Bank Deposit Code");
                    //MICRBankDepCode.TESTFIELD(MICRBankDepCode."Bank No.");
                    "Bank No." := MICRBankDepCode."Bank No.";

                    if xRec."Bank Deposit Code" <> "Bank Deposit Code" then begin
                        if PDCEntry.Get("Entry No.") then begin
                            PDCEntry.Validate(PDCEntry."Bank Deposit Code", "Bank Deposit Code");
                            PDCEntry.Modify;
                        end;
                    end;
                end;
            end;
        }
        field(13; "Bank Deposit Description"; Text[30])
        {
        }
        field(14; Deposit; Boolean)
        {

            trigger OnValidate()
            begin
                TestField("Bank Deposit Code");
                TestField("Bank No.");
                TestField("Customer No.");
                TestField("Cheque No.");
                TestField("Cheque Date");
                TestField(Amount);
                //001 - Start
                //TESTFIELD("MICR Code");
                //001 - Stop

                /*recDepCheck.SETRANGE(recDepCheck."Entry No.","Entry No.");
                IF recDepCheck.FINDFIRST THEN BEGIN
                  recDepCheck."Deposited By" := USERID;
                  recDepCheck.MODIFY;
                END;*/

                "Deposited By" := UserId;
                Modify;

            end;
        }
        field(15; "Pay Slip No."; Code[20])
        {
        }
        field(16; "Creation Date Time"; DateTime)
        {
        }
        field(17; "PDC Posted"; Boolean)
        {
            Editable = true;
        }
        field(18; Update; Boolean)
        {
        }
        field(19; "Deposited Date"; Date)
        {
        }
        field(50000; "Deposited By"; Code[50])
        {
        }
        field(50001; "Account Type"; Option)
        {
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
    }

    keys
    {
        key(Key1; "Cheque Type", "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Bank Deposit Code", "Res Center")
        {
        }
        key(Key3; "Bank Deposit Code", "Deposited Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //TESTFIELD("PDC Posted",FALSE);
    end;

    var
        recDepCheck: Record "Deposit Cheques";
        MICRBankDepCode: Record "MICR Codes";
        PDCEntry: Record PDC;
        Text101: label 'Total cheques to deposit    #1############\\';
        Text102: label 'Posting Cheques                  #2############\\';
        Text201: label 'Please enter the PDC Date #1###########';
        Text202: label 'Cheques are being deposited for Responsibility Centre %1 by another user. Plesea check.';
        Text203: label 'This will assign Pay Slip Nos to the cheques.\\ The selected cheques will not be available on this screen.\\ You will need to post these cheques from "PDC Entry PaySlip Generated" form. Do you want to continue?';
        Text1001: label 'PLEASE NOTE: \\There has been a slight change in the PDC fucntionality.\\ You can now print the Pay Slips for selected cheques in advance.\ System will separate such cheques in another screen called "PDC Entry PaySlip Generated".\';
        Text1002: label '\The advance Pay Slip cheques MUST BE posted separately, from the above mentioned screen.\ Also you can reprint Pay Slips from "PDC Entry Posted" Screen.';
        Text1003: label 'Also, At a time, only one user from each branch is allowed to use "Deposit Cheques" screen.\\ All other functions remain the same.\\';
        Text1004: label 'Please contact Onkar on 09371670339 in case you face any difficulty in PDC related to these changes.';
        DepCheques: Record "Deposit Cheques";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        RespCentre: Record "Responsibility Center";
        Cust: Record Customer;
        UserMgt: Codeunit "User Setup Management";
        Window: Dialog;
        Cntr: Integer;
        PDCDate: Date;
        Changed: Boolean;
        CustName: Text[50];
        PaySlipGenForm: Page "PDC Deposit Cheques";
        Text1010: label 'There is nothing to post.';
        vendr: Record Vendor;
        vendrname: Text[50];
        RespCentre1: Record "Responsibility Center";


    procedure GetCheques(pDate: Date)
    var
        DepCheques: Record "Deposit Cheques";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        PDCEntry: Record PDC;
        RespCentre: Record "Responsibility Center";
        Cust: Record Customer;
        UserMgt: Codeunit "User Setup Management";
        Window: Dialog;
        Cntr: Integer;
        PDCDate: Date;
        Changed: Boolean;
        CustName: Text[50];
        PaySlipGenForm: Page "PDC Deposit Cheques";
    begin
        DepCheques.Reset;
        //DepCheques.SETRANGE(DepCheques."Res Center",UserMgt.GetSalesFilter);
        DepCheques.SetRange("Pay Slip No.", '');
        if DepCheques.Find('-') then
            repeat
                if PDCEntry.Get(DepCheques."Entry No.") then begin
                    if PDCEntry."PDC Status" <> PDCEntry."pdc status"::"PaySlip Generated" then begin
                        PDCEntry."PDC Status" := PDCEntry."pdc status"::"PaySlip Generated";
                        PDCEntry.Modify;
                    end;
                end;
            until DepCheques.Next = 0;
    end;


    procedure PostCheques()
    var
        Text000: label 'You must specify %1 or %2.';
        Text001: label 'Do you want to deposit the cheques and post the PDC lines?';
        Text002: label 'The Deposit Slip is posted successfully.';
        Text003: label 'This PDC is not applied. Do you want to continue?';
        Text004: label 'PDC cannot be Posted before the PDC Cheque date.';
        Text005: label 'You have not selected any cheques for Depositing.';
        GJLine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        CustLedgEntry: Record "Cust. Ledger Entry";
        PDCApplnEntry: Record "PDC Application Entry";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;
        PayinSlip: Report "Dimension Item Report";
    begin
        if not Confirm(Text001) then
            exit;

        DepCheques.Reset;
        //DepCheques.SETRANGE(DepCheques."Res Center","Res Center");
        DepCheques.SetRange(DepCheques.Deposit, true);
        DepCheques.SetRange(DepCheques."PDC Posted", false);
        DepCheques.SetRange(DepCheques."Deposited By", UserId);

        if DepCheques.FindSet then begin
            Message('The Pay Slip will be printed on the default printer.');
            RespCentre.Get("Res Center");

            Window.Open(Text101 + Text102);
            Window.Update(1, DepCheques.Count);

            GLSetup.Get;
            GLSetup.TestField(GLSetup."Cust PDC Batch No.");

            DepCheques.SetRange("Cheque Type", DepCheques."cheque type"::PDC);
            if DepCheques.Find('-') then
                repeat
                    PDCEntry.Get(DepCheques."Entry No.");


                    if PDCEntry."PDC Status" = PDCEntry."pdc status"::"PaySlip Generated" then begin

                        PDCApplnEntry.Reset;
                        PDCApplnEntry.SetRange(PDCApplnEntry."PDC Entry No.", PDCEntry."Entry No.");
                        if PDCApplnEntry.Find('-') then
                            repeat
                                CustLedgEntry.Get(PDCApplnEntry."Cust Ledger Entry No.");
                                CustLedgEntry."Applies-to ID" := PDCEntry."Applies-to ID";
                                CustLedgEntry.Validate("Amount to Apply", PDCApplnEntry."Amount to Apply");
                                CustLedgEntry.Modify;
                            until PDCApplnEntry.Next = 0;

                        GJLine.Reset;
                        GJLine.SetRange(GJLine."Journal Template Name", 'GENERAL');
                        GJLine.SetRange(GJLine."Journal Batch Name", GLSetup."Cust PDC Batch No.");
                        if GJLine.FindLast then
                            LineNo := GJLine."Line No." + 10000
                        else
                            LineNo := 10000;

                        GJLine.Init;
                        GJLine."Journal Template Name" := 'GENERAL';
                        GJLine.Validate(GJLine."Journal Batch Name", GLSetup."Cust PDC Batch No.");
                        GJLine.Validate(GJLine."Source Code", 'GENJNL');
                        GJLine."Line No." := LineNo;
                        GJLine.Validate(GJLine."Account Type", GJLine."account type"::Customer);
                        GJLine.Validate(GJLine."Account No.", PDCEntry."Account No.");
                        GJLine."Posting Date" := WorkDate;//PDCDate;
                        GJLine.Validate(GJLine."Document Type", GJLine."document type"::Payment);
                        if GJLine."Document No." = '' then
                            GJLine."Document No." := 'PDC' + PDCEntry."PDC Cheque No.";
                        GJLine.Validate(GJLine."Credit Amount", PDCEntry."PDC Amount");
                        GJLine.Validate(GJLine."Bal. Account Type", GJLine."bal. account type"::"Bank Account");
                        GJLine.Validate(GJLine."Bal. Account No.", DepCheques."Bank No.");
                        GJLine."External Document No." := PDCEntry."PDC Cheque No.";
                        GJLine."PDC Cheque Line" := PDCEntry."Entry No.";
                        GJLine."Cheque No." := PDCEntry."PDC Cheque No.";
                        GJLine."Cheque Date" := PDCEntry."PDC Cheque Date";
                        GJLine."Document Date" := PDCEntry."PDC Received Date";
                        GJLine."Applies-to ID" := PDCEntry."Applies-to ID";
                        GJLine."Cheque Deposited" := true;
                        if GJLine."Shortcut Dimension 2 Code" = '' then
                            GJLine.Validate(GJLine."Shortcut Dimension 2 Code", RespCentre."Global Dimension 2 Code");
                        /*
                        JournalLineDim.RESET;
                        JournalLineDim.SETRANGE(JournalLineDim."Table ID",81);
                        JournalLineDim.SETRANGE(JournalLineDim."Journal Template Name",'GENERAL');
                        JournalLineDim.SETRANGE(JournalLineDim."Journal Batch Name",GLSetup."Cust PDC Batch No.");
                        JournalLineDim.SETRANGE(JournalLineDim."Journal Line No.",LineNo);
                        */

                        //IF JournalLineDim.FIND('-') THEN;
                        GenJnlPostLine.RunWithCheck(GJLine);

                        Clear(GenJnlPostLine);
                        Clear(GJLine);

                        PDCEntry."PDC Status" := PDCEntry."pdc status"::Posted;
                        PDCEntry."Document No." := 'PDC' + PDCEntry."PDC Cheque No.";
                        PDCEntry."PDC Posted By" := UserId;
                        PDCEntry."PDC Deposited" := true;
                        PDCEntry."PDC Deposit Date" := WorkDate; //PDCDate;
                        PDCEntry."Pay Slip No." := PDCEntry."Pay Slip No.";
                        PDCEntry.Modify;

                        /*{
                        PDCApplnEntry.RESET;
                        PDCApplnEntry.SETRANGE(PDCApplnEntry."PDC Entry No.","Entry No.");
                        IF PDCApplnEntry.FIND('-') THEN
                          PDCApplnEntry.DELETEALL;
                        }*/
                        Cntr += 1;
                        Window.Update(2, Cntr);
                    end;
                    DepCheques."PDC Posted" := true;
                    DepCheques."Deposited Date" := WorkDate;
                    DepCheques.Modify;
                until DepCheques.Next = 0;

            Window.Close;

            DepCheques.Reset;
            DepCheques.SetRange(DepCheques.Deposit, true);
            DepCheques.SetRange(DepCheques."PDC Posted", true);
            DepCheques.SetRange(DepCheques."Deposited Date", WorkDate);
            DepCheques.SetRange(DepCheques."Deposited By", UserId);
            if DepCheques.Find('-') then begin
                //  REPORT.RUNMODAL(50005,TRUE,TRUE,DepCheques);
            end;
            Message(Text002);
        end else
            Message(Text1010);

    end;


    procedure InsertDepositCheques(PDCEntryNo: Integer)
    begin
        if PDCEntryNo > 0 then begin
            PDCEntry.Get(PDCEntryNo);
            DepCheques.Init;
            DepCheques."Account Type" := PDCEntry."Account Type";
            DepCheques."Cheque Type" := DepCheques."cheque type"::PDC;
            DepCheques."Entry No." := PDCEntry."Entry No.";
            DepCheques."Bank No." := PDCEntry."Bank No.";
            DepCheques."Res Center" := PDCEntry."Res Center";
            DepCheques."Customer No." := PDCEntry."Account No.";
            DepCheques."Cheque No." := PDCEntry."PDC Cheque No.";
            DepCheques."Cheque Date" := PDCEntry."PDC Cheque Date";
            DepCheques.Amount := PDCEntry."PDC Amount";
            DepCheques.Update := PDCEntry.Update;
            DepCheques.Validate("MICR Code", PDCEntry."MICR Code");
            DepCheques.Validate("Bank Deposit Code", PDCEntry."Bank Deposit Code");
            DepCheques."Issued Bank Name" := PDCEntry."Bank Name";
            DepCheques."Issued Bank Branch" := PDCEntry."Bank Branch";
            DepCheques."Pay Slip No." := PDCEntry."Pay Slip No.";
            DepCheques."Creation Date Time" := CurrentDatetime;
            DepCheques.Insert;
        end;
    end;


    procedure VendorPostCheques()
    var
        GJLine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        PDCApplnEntry: Record "PDC Application Entry";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        LineNo: Integer;
        PayinSlip: Report "Dimension Item Report";
        VendrLegEntry: Record "Vendor Ledger Entry";
        Text000: label 'You must specify %1 or %2.';
        Text001: label 'Do you want to deposit the cheques and post the PDC lines?';
        Text002: label 'The Deposit Slip is posted successfully.';
        Text003: label 'This PDC is not applied. Do you want to continue?';
        Text004: label 'PDC cannot be Posted before the PDC Cheque date.';
        Text005: label 'You have not selected any cheques for Depositing.';
    begin

        if not Confirm(Text001) then
            exit;

        DepCheques.Reset;
        //DepCheques.SETRANGE(DepCheques."Res Center","Res Center");
        DepCheques.SetRange(DepCheques.Deposit, true);
        DepCheques.SetRange(DepCheques."PDC Posted", false);
        DepCheques.SetRange(DepCheques."Deposited By", UserId);

        if DepCheques.FindSet then begin
            Message('The Pay Slip will be printed on the default printer.');

            Window.Open(Text101 + Text102);
            Window.Update(1, DepCheques.Count);

            GLSetup.Get;
            GLSetup.TestField(GLSetup."Vend PDC Batch No.");

            DepCheques.SetRange("Cheque Type", DepCheques."cheque type"::PDC);
            if DepCheques.Find('-') then
                repeat
                    PDCEntry.Get(DepCheques."Entry No.");


                    if PDCEntry."PDC Status" = PDCEntry."pdc status"::"PaySlip Generated" then begin

                        PDCApplnEntry.Reset;
                        PDCApplnEntry.SetRange(PDCApplnEntry."PDC Entry No.", PDCEntry."Entry No.");
                        if PDCApplnEntry.Find('-') then
                            repeat
                                VendrLegEntry.Get(PDCApplnEntry."Cust Ledger Entry No.");
                                VendrLegEntry."Applies-to ID" := PDCEntry."Applies-to ID";
                                VendrLegEntry.Validate("Amount to Apply", PDCApplnEntry."Amount to Apply");
                                VendrLegEntry.Modify;
                            until PDCApplnEntry.Next = 0;

                        GJLine.Reset;
                        GJLine.SetRange(GJLine."Journal Template Name", 'GENERAL');
                        GJLine.SetRange(GJLine."Journal Batch Name", GLSetup."Vend PDC Batch No.");
                        if GJLine.FindLast then
                            LineNo := GJLine."Line No." + 10000
                        else
                            LineNo := 10000;

                        GJLine.Init;
                        GJLine."Journal Template Name" := 'GENERAL';
                        GJLine.Validate(GJLine."Journal Batch Name", GLSetup."Vend PDC Batch No.");
                        GJLine.Validate(GJLine."Source Code", 'GENJNL');
                        GJLine."Line No." := LineNo;
                        GJLine.Validate(GJLine."Account Type", GJLine."account type"::Vendor);
                        GJLine.Validate(GJLine."Account No.", PDCEntry."Account No.");
                        GJLine."Posting Date" := WorkDate;//PDCDate;
                        GJLine.Validate(GJLine."Document Type", GJLine."document type"::Payment);
                        if GJLine."Document No." = '' then
                            GJLine."Document No." := 'PDC' + PDCEntry."PDC Cheque No.";
                        GJLine.Validate(GJLine."Credit Amount", -PDCEntry."PDC Amount");
                        GJLine.Validate(GJLine."Bal. Account Type", GJLine."bal. account type"::"Bank Account");
                        GJLine.Validate(GJLine."Bal. Account No.", DepCheques."Bank No.");
                        GJLine."External Document No." := PDCEntry."PDC Cheque No.";
                        GJLine."PDC Cheque Line" := PDCEntry."Entry No.";
                        GJLine."Cheque No." := PDCEntry."PDC Cheque No.";
                        GJLine."Cheque Date" := PDCEntry."PDC Cheque Date";
                        GJLine."Document Date" := PDCEntry."PDC Received Date";
                        GJLine."Applies-to ID" := PDCEntry."Applies-to ID";
                        GJLine."Cheque Deposited" := true;
                        RespCentre1.Get(PDCEntry."Res Center");
                        if GJLine."Shortcut Dimension 1 Code" = '' then
                            GJLine.Validate(GJLine."Shortcut Dimension 1 Code", RespCentre1."Global Dimension 1 Code");

                        if GJLine."Shortcut Dimension 2 Code" = '' then
                            GJLine.Validate(GJLine."Shortcut Dimension 2 Code", RespCentre1."Global Dimension 2 Code");
                        /*
                        JournalLineDim.RESET;
                        JournalLineDim.SETRANGE(JournalLineDim."Table ID",81);
                        JournalLineDim.SETRANGE(JournalLineDim."Journal Template Name",'GENERAL');
                        JournalLineDim.SETRANGE(JournalLineDim."Journal Batch Name",GLSetup."Vend PDC Batch No.");
                        JournalLineDim.SETRANGE(JournalLineDim."Journal Line No.",LineNo);
                        */

                        //IF JournalLineDim.FIND('-') THEN;
                        GenJnlPostLine.RunWithCheck(GJLine);

                        Clear(GenJnlPostLine);
                        Clear(GJLine);

                        PDCEntry."PDC Status" := PDCEntry."pdc status"::Posted;
                        PDCEntry."Document No." := 'PDC' + PDCEntry."PDC Cheque No.";
                        PDCEntry."PDC Posted By" := UserId;
                        PDCEntry."PDC Deposited" := true;
                        PDCEntry."PDC Deposit Date" := WorkDate; //PDCDate;
                        PDCEntry."Pay Slip No." := PDCEntry."Pay Slip No.";
                        PDCEntry.Modify;

                        /*{
                        PDCApplnEntry.RESET;
                        PDCApplnEntry.SETRANGE(PDCApplnEntry."PDC Entry No.","Entry No.");
                        IF PDCApplnEntry.FIND('-') THEN
                          PDCApplnEntry.DELETEALL;
                        }*/
                        Cntr += 1;
                        Window.Update(2, Cntr);
                    end;
                    DepCheques."PDC Posted" := true;
                    DepCheques."Deposited Date" := WorkDate;
                    DepCheques.Modify;
                until DepCheques.Next = 0;

            Window.Close;

            DepCheques.Reset;
            DepCheques.SetRange(DepCheques.Deposit, true);
            DepCheques.SetRange(DepCheques."PDC Posted", true);
            DepCheques.SetRange(DepCheques."Deposited Date", WorkDate);
            DepCheques.SetRange(DepCheques."Deposited By", UserId);
            if DepCheques.Find('-') then begin
                //  REPORT.RUNMODAL(50005,TRUE,TRUE,DepCheques);
            end;
            Message(Text002);
        end else
            Message(Text1010);

    end;
}

