Table 50078 "Quality Sub Groups Tests"
{

    fields
    {
        field(1; "Test Code"; Code[20])
        {
            // TableRelation = "Quality Test M";

            trigger OnValidate()
            begin
                // RecTestMaster.Reset;
                // RecTestMaster.SetRange("Test Id", Rec."Test Code");
                // if RecTestMaster.FindFirst then begin
                //     Rec."Test Name" := RecTestMaster.Description;
                // end aks check

            end;
        }
        field(2; "Sequence number"; Integer)
        {
        }
        field(3; "Effective Date"; Date)
        {
        }
        field(4; "Expiration Date"; Date)
        {
        }
        field(5; "Certificate of analysis report"; Boolean)
        {
            Description = 'Not Used';
        }
        field(6; "Action on failure"; Option)
        {
            Description = 'Not Used';
            OptionMembers = Fail,Accept;
        }
        field(7; "Aceptable Quality Level"; Decimal)
        {
            Description = 'Not Used';
        }
        field(10; "Standard Value"; Decimal)
        {
        }
        field(11; "Minimum Value"; Decimal)
        {
        }
        field(12; "Maximum Value"; Decimal)
        {
        }
        field(18; "Test instrument"; Code[20])
        {
            TableRelation = "Quality Test Instruments M".TestInstrument;

            trigger OnValidate()
            begin
                GetUnit("Test instrument");
            end;
        }
        field(19; "Unit of Measure"; Code[10])
        {
        }
        field(20; "Test Group Code"; Code[20])
        {
            TableRelation = "Quality Tests Groups M";

            trigger OnValidate()
            begin
                GetTestName("Test Group Code");
            end;
        }
        field(21; "Created Date"; DateTime)
        {
        }
        field(22; "Created By"; Code[100])
        {
        }
        field(23; "Modify Date"; DateTime)
        {
        }
        field(24; "Modify By"; Code[100])
        {
        }
        field(25; "Test Group Name"; Text[200])
        {
        }
        field(26; "Test Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Test Code", "Test Group Code", "Sequence number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDatetime;
        // QOTestList."Maximum Value" := "Minimum Value"; aks check
    end;

    trigger OnModify()
    begin

        "Modify By" := UserId;
        "Modify Date" := CurrentDatetime;
    end;

    var
        // QOTestList: Record "Store Table For QO"; aks check
        RecQtI: Record "Quality Test Instruments M";
        RecQTG: Record "Quality Tests Groups M";
    // RecTestMaster: Record "Quality Test M";

    local procedure GetUnit(TestInstrument: Text[50])
    begin
        if TestInstrument <> '' then begin
            RecQtI.Get(TestInstrument);
            "Unit of Measure" := RecQtI."Unit of Measure";
        end
    end;

    local procedure GetTestName(TestGrpCode: Code[20])
    begin
        if TestGrpCode <> '' then begin
            RecQTG.Get(TestGrpCode);
            "Test Group Name" := RecQTG.Description;
        end
    end;
}

