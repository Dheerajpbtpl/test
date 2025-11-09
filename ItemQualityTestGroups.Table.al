Table 50080 "Item Quality Test Groups"
{

    fields
    {
        field(1; "Quality Code"; Code[20])
        {

            trigger OnValidate()
            begin

                if "Quality Code" <> '' then begin
                    PurchaseSetup.Get;
                    // NoSeriesMgt.TestManual(PurchaseSetup."Quality Item GroupCode");not created field

                    "No. Series" := '';
                    NoSeriesMgt.SetSeries("Quality Code");
                end
            end;
        }
        field(2; "Item Number"; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                GetItemName("Item Number");
            end;
        }
        field(3; "Group Code"; Code[20])
        {
            TableRelation = "Quality Tests Groups M"."Test Group Code";

            trigger OnValidate()
            begin
                GetGroup("Group Code");
            end;
        }
        field(4; "Item Name"; Text[100])
        {
        }
        field(5; "Group Name"; Text[100])
        {
        }
        field(6; "Create Date"; DateTime)
        {
        }
        field(7; "Created By"; Code[50])
        {
        }
        field(8; "Modify Date"; DateTime)
        {
        }
        field(9; "Modify By"; Code[50])
        {
        }
        field(10; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(11; Description; Code[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Item Number", "Group Code")
        {
            Clustered = true;
        }
        key(Key2; "Group Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Create Date" := CurrentDatetime;


        if "Quality Code" = '' then begin
            PurchaseSetup.Get;
            // PurchaseSetup.TESTFIELD("Quality Item GroupCode"); not created field
            // NoSeriesMgt.InitSeries(PurchaseSetup."Quality Item GroupCode", xRec."No. Series",0D,"Quality Code","No. Series");not created field
        end;
    end;

    trigger OnModify()
    begin
        //CodeUnitQualityPurchHeader.RUN;
        "Modify By" := UserId;
        "Modify Date" := CurrentDatetime;
    end;

    var
        RecItem: Record Item;
        RecQTG: Record "Quality Tests Groups M";
        PurchaseSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure GetItemName(ItemNo: Code[20])
    begin
        if ItemNo <> '' then begin
            RecItem.Get(ItemNo);
            "Item Name" := RecItem.Description;
        end
    end;

    local procedure GetGroup(GroupNo: Code[20])
    begin
        if GroupNo <> '' then begin
            RecQTG.Get(GroupNo);
            "Group Name" := RecQTG.Description;
        end
    end;
}

