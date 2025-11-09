Table 50091 "Record Del. Table Rel. Error"
{
    // **************************************************************************************************************************
    // Created and Designed by Olof Simren 2014
    // Downloaded from olofsimren.com
    // 
    // For illustration only, without warranty, free to use as you want.
    // **************************************************************************************************************************

    DrillDownPageID = "Record Del. Table Rel. Error";
    LookupPageID = "Record Del. Table Rel. Error";

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Editable = false;
        }
        field(2; "Entry No."; Integer)
        {
            Editable = false;
        }
        field(3; "Field No."; Integer)
        {
            Editable = false;
        }
        field(4; "Field Name"; Text[30])
        {
            CalcFormula = lookup(Field.FieldName where(TableNo = field("Table ID"),
                                                        "No." = field("Field No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Error; Text[250])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

