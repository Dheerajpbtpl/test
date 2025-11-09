Table 50001 "MICR Codes"
{

    fields
    {
        field(1; "Code Type"; Option)
        {
            OptionCaption = 'MICR,BankDeposit';
            OptionMembers = MICR,BankDeposit;
        }
        field(2; "MICR Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; "Bank Name"; Text[250])
        {
        }
        field(4; "Bank Branch"; Text[250])
        {
        }
        field(5; "Bank No."; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(6; Description; Text[30])
        {
        }
        field(7; "Responsibility Centre"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(8; "Branch City"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Code Type", "MICR Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

