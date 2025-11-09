Table 50083 "SMS Body Template-PBTPL"
{

    fields
    {
        field(1; ID; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; MsgTitle; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; MsgBody; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; CreatedBy; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; CreatedDate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; ModifyBy; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; ModifyDate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; ID, MsgTitle, MsgBody)
        {
        }
    }

    trigger OnInsert()
    begin
        CreatedBy := UserId;
        CreatedDate := CreateDatetime(Today, Time);
        Rec.Reset;
        ID := 'SmsTemp-' + Format(Rec.Count + 1);
    end;

    trigger OnModify()
    begin
        ModifyBy := UserId;
        ModifyDate := CreateDatetime(Today, Time);
    end;
}

