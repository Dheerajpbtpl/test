Table 50090 "Record Deletion Table"
{
    // **************************************************************************************************************************
    // Created and Designed by Olof Simren 2014
    // Downloaded from olofsimren.com
    // 
    // For illustration only, without warranty, free to use as you want.
    // **************************************************************************************************************************

    Permissions = TableData "Record Deletion Table" = rimd;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Editable = false;
        }
        field(2; "Table Name"; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Table),
                                                                        "Object ID" = field("Table ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "No. of Records"; Integer)
        {
            CalcFormula = lookup("Table Information"."No. of Records" where("Company Name" = field(Company),
                                                                             "Table No." = field("Table ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "No. of Table Relation Errors"; Integer)
        {
            CalcFormula = count("Record Del. Table Rel. Error" where("Table ID" = field("Table ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Delete Records"; Boolean)
        {
        }
        field(6; Company; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Table ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Company := COMPANYNAME;
    end;
}

