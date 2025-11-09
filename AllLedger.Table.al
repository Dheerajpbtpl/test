Table 50011 "All Ledger"
{

    fields
    {
        field(1; "Ledger Type"; Option)
        {
            OptionMembers = " ",Customer,Vendor,"G/L","Bank Account";
        }
        field(2; "Ledger No."; Code[20])
        {
            TableRelation = if ("Ledger Type" = filter(Customer)) Customer
            else
            if ("Ledger Type" = filter(Vendor)) Vendor
            else
            if ("Ledger Type" = filter("G/L")) "G/L Account"
            else
            if ("Ledger Type" = filter("Bank Account")) "Bank Account";

            trigger OnValidate()
            begin
                if "Ledger Type" = "ledger type"::"Bank Account" then begin
                    BankAct.Reset;
                    BankAct.SetRange("No.", "Ledger No.");
                    if BankAct.FindFirst then
                        "Ledger Name" := BankAct.Name;
                end;

                if "Ledger Type" = "ledger type"::Customer then begin
                    Customer.Reset;
                    Customer.SetRange("No.", "Ledger No.");
                    if Customer.FindFirst then
                        "Ledger Name" := Customer.Name;
                end;

                if "Ledger Type" = "ledger type"::"G/L" then begin
                    GL.Reset;
                    GL.SetRange("No.", "Ledger No.");
                    if GL.FindFirst then
                        "Ledger Name" := GL.Name;
                end;

                if "Ledger Type" = "ledger type"::Vendor then begin
                    Vendor.Reset;
                    Vendor.SetRange("No.", "Ledger No.");
                    if Vendor.FindFirst then
                        "Ledger Name" := Vendor.Name;
                end;
            end;
        }
        field(3; "Ledger Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Ledger Type", "Ledger No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        GL: Record "G/L Account";
        BankAct: Record "Bank Account";
}

