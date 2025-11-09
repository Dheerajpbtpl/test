Table 50020 "Marin Policy No."
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; Dated; Date)
        {
        }
        field(3; "Party Code"; Code[50])
        {
        }
        field(4; "Party Name"; Text[50])
        {
        }
        field(5; "Bill Amount"; Decimal)
        {
        }
        field(6; "Start Date"; Date)
        {
        }
        field(7; "Sum Insured"; Decimal)
        {
        }
        field(8; Balance; Decimal)
        {
        }
        field(9; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Transfer Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Transfer Order";
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

