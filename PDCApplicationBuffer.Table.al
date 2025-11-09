Table 50002 "PDC Application Buffer"
{
    DrillDownPageID = "PDC Application Buffer";
    LookupPageID = "PDC Application Buffer";

    fields
    {
        field(1; "PDC Entry No."; Integer)
        {
            Editable = false;
        }
        field(2; "Cust Ledger Entry No."; Integer)
        {
            BlankZero = true;
            Editable = false;
            NotBlank = true;
        }
        field(3; "Document Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(4; "Document No."; Code[20])
        {
        }
        field(5; "Document Date"; Date)
        {
            Editable = false;
        }
        field(6; "Due Date"; Date)
        {
            Editable = false;
        }
        field(7; "Customer No."; Code[20])
        {
            Editable = false;
        }
        field(8; "Customer Name"; Text[50])
        {
            Editable = false;
        }
        field(9; "Document Amount"; Decimal)
        {
            Editable = false;
        }
        field(10; "Remaining Amount"; Decimal)
        {
            Editable = false;
        }
        field(11; "PDC Unposted Amount"; Decimal)
        {
            Editable = false;
        }
        field(12; "Amount Available for Appln"; Decimal)
        {
            Editable = false;
        }
        field(13; "PDC Amount Available"; Decimal)
        {
            Editable = false;
        }
        field(14; "Amount to Apply"; Decimal)
        {

            trigger OnValidate()
            begin
                Message(Format("Account Type"));
                if "Account Type" = "account type"::Customer then begin
                    if "Amount to Apply" < 0 then
                        Error('The minimum permitted value is 0');

                    if "Amount to Apply" <> 0
                      then
                        TestField(Apply);

                    if "Amount to Apply" > "Amount Available for Appln"
                      then
                        Error(Text001, "Amount Available for Appln")
                end;
                if "Account Type" = "account type"::Vendor then begin

                    if "Amount to Apply" > 0 then
                        Error('The maximum permitted value is 0');

                    if "Amount to Apply" <> 0
                      then
                        TestField(Apply);
                    /*
                      IF "Amount to Apply" < "Amount Available for Appln"
                        THEN ERROR(Text001,"Amount Available for Appln");
                        */
                end;

                ApplnBuffer1.Reset;
                ApplnBuffer1.SetRange(ApplnBuffer1."PDC Entry No.", "PDC Entry No.");
                ApplnBuffer1.SetFilter(ApplnBuffer1."Cust Ledger Entry No.", '<>%1', "Cust Ledger Entry No.");
                if ("Account Type" = "account type"::Customer) then begin

                    if ApplnBuffer1.Find('-') then
                        repeat
                            AvlbForAppln += ApplnBuffer1."Amount to Apply";
                        until ApplnBuffer1.Next = 0;

                    AvlbForAppln := "PDC Amount Available" - AvlbForAppln;

                    if "Amount to Apply" > AvlbForAppln
                      then
                        Error(Text001, AvlbForAppln);

                end
                else
                    if ("Account Type" = "account type"::Vendor) then begin
                        if ApplnBuffer1.Find('-') then
                            repeat
                                AvlbForAppln += Abs(ApplnBuffer1."Amount to Apply");
                            until ApplnBuffer1.Next = 0;
                        AvlbForAppln := "PDC Amount Available" - Abs(AvlbForAppln);

                        if Abs("Amount to Apply") > AvlbForAppln
                         then
                            Error(Text001, -AvlbForAppln);
                    end

            end;
        }
        field(15; Apply; Boolean)
        {

            trigger OnValidate()
            begin
                if not Apply then
                    "Amount to Apply" := 0;
            end;
        }
        field(50; "Account Type"; Option)
        {
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(51; "item Detail"; Text[60])
        {
            CalcFormula = min("Purch. Inv. Line".Description where("Document No." = field("Document No."),
                                                                    Type = filter(Item)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "PDC Entry No.", "Cust Ledger Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Cust Ledger Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label 'Maximum Amount to apply is %1. Please check the entry.';
        PDCEntry: Record PDC;
        ApplnBuffer1: Record "PDC Application Buffer";
        AvlbForAppln: Decimal;
}

