Table 50058 "Pay Head Details"
{

    fields
    {
        field(1; "Pay Head"; Code[50])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Effective Date"; Date)
        {

            trigger OnValidate()
            begin
                /*IF PayHead.GET("Pay Head") THEN
                  Type := PayHead."Line Number"
                ELSE
                  Type := Type::" ";*/

            end;
        }
        field(10; Type; Option)
        {
            OptionCaption = ' ,Deduction From Employees,Earning for Employees,Employees Statutory Deduction,Employer''s Statutory Contribution,Gratuity,Loans And Advances,Reimbursements to Employee';
            OptionMembers = " ","Deduction From Employees","Earning for Employees","Employees Statutory Deduction","Employer's Statutory Contribution",Gratuity,"Loans And Advances","Reimbursements to Employee";
        }
        field(11; "From Amount"; Decimal)
        {
        }
        field(12; "Amount Upto"; Decimal)
        {
        }
        field(13; "Slab Type"; Option)
        {
            OptionCaption = ' ,Value,Percentage';
            OptionMembers = " ",Value,Percentage;
        }
        field(14; "Value Basis"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Pay Head", "Effective Date", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PayHead: Record "Pay Head-PBTPL(Payroll)";
}

