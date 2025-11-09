Table 50062 "Accounting Voucher Line"
{
    Caption = 'Payment Invoice Line New';

    fields
    {
        field(1; "Transaction No"; Code[30])
        {
            Caption = 'Transaction No';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner";

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
                Location: Record Location;
                AcctOrderHeader: Record "Accounting Voucher Header";
                Vend: Record Vendor;
                GlAcc: Record "G/L Account";
                BankAcct: Record "Bank Account";
                Cust: Record Customer;
                FixedAcc: Record "Fixed Asset";
                IcPart: Record "IC Partner";
            begin
                TestStatusOpen;

                if "Account No." <> '' then begin
                    AcctOrderHeader.Reset;
                    AcctOrderHeader.SetRange(AcctOrderHeader."Transaction No", "Transaction No");
                    AcctOrderHeader.FindFirst;
                    AcctOrderHeader.TestField(AcctOrderHeader."Document Type");
                    AcctOrderHeader.TestField(AcctOrderHeader.Location);
                    AcctOrderHeader.TestField(AcctOrderHeader."Posting Date");
                    AcctOrderHeader.TestField(AcctOrderHeader."Journal Template Name");
                    AcctOrderHeader.TestField(AcctOrderHeader."Journal Batch Name");

                    "Posting Date" := AcctOrderHeader."Posting Date";
                    "Document Type" := AcctOrderHeader."Document Sub Type";
                    "Location Code" := AcctOrderHeader.Location;
                    "Journal Template Name" := AcctOrderHeader."Journal Template Name";
                    "Journal Batch Name" := AcctOrderHeader."Journal Batch Name";

                    if Location.Get(AcctOrderHeader.Location) then begin
                        //"Shortcut Dimension 1 Code":=
                        // "Shortcut Dimension 2 Code":=
                    end;


                    if "Account Type" = "account type"::"G/L Account" then begin
                        GlAcc.Get("Account No.");
                        "Account Name" := GlAcc.Name;
                    end else
                        if "Account Type" = "account type"::Customer then begin
                            Cust.Get("Account No.");
                            "Account Name" := Cust.Name;
                        end else
                            if "Account Type" = "account type"::Vendor then begin
                                Vend.Get("Account No.");
                                "Account Name" := Vend.Name;
                            end else
                                if "Account Type" = "account type"::"Bank Account" then begin
                                    BankAcct.Get("Account No.");
                                    "Account Name" := BankAcct.Name;
                                end else
                                    if "Account Type" = "account type"::"Fixed Asset" then begin
                                        FixedAcc.Get("Account No.");
                                        "Account Name" := FixedAcc.Description;
                                    end else
                                        if "Account Type" = "account type"::"IC Partner" then begin
                                            IcPart.Get("Account No.");
                                            "Account Name" := IcPart.Name;
                                        end
                end;
            end;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
        }
        field(6; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(11; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                               Blocked = const(false))
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Bal. Account Type" = const("IC Partner")) "IC Partner";

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
                Location: Record Location;
            begin
            end;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';

            trigger OnValidate()
            begin
                TestStatusOpen;

                "Debit Amount" := 0;
                "Credit Amount" := 0;
                if Amount > 0 then
                    "Debit Amount" := Amount
                else
                    "Credit Amount" := -Amount;
            end;
        }
        field(14; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';

            trigger OnValidate()
            begin
                TestStatusOpen;

                "Credit Amount" := 0;
                Amount := "Debit Amount";
            end;
        }
        field(15; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';

            trigger OnValidate()
            begin
                TestStatusOpen;

                "Debit Amount" := 0;

                Amount := -"Credit Amount";
            end;
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
        }
        field(17; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)';
            Editable = false;
        }
        field(18; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(19; "Sales/Purch. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales/Purch. (LCY)';
        }
        field(20; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Profit (LCY)';
        }
        field(21; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)';
        }
        field(22; "Bill-to/Pay-to No."; Code[20])
        {
            Caption = 'Bill-to/Pay-to No.';
            Editable = false;
            TableRelation = if ("Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor;
        }
        field(23; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = if ("Account Type" = const(Customer)) "Customer Posting Group"
            else
            if ("Account Type" = const(Vendor)) "Vendor Posting Group"
            else
            if ("Account Type" = const("Fixed Asset")) "FA Posting Group";
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(26; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(29; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(30; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(34; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(35; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(36; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
                AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
                AccNo: Code[20];
            begin
                xRec.Amount := Amount;
                xRec."Currency Code" := "Currency Code";
                xRec."Posting Date" := "Posting Date";

                GetAccTypeAndNo(AccType, AccNo);
                Clear(CustLedgEntry);
                Clear(VendLedgEntry);


                case AccType of
                    Acctype::Customer:
                        LookUpAppliesToDocCust(AccNo);
                    Acctype::Vendor:
                        LookUpAppliesToDocVend(AccNo);
                end;
            end;

            trigger OnValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                TempGenJnlLine: Record "Gen. Journal Line" temporary;
                VendLedgEntry2: Record "Vendor Ledger Entry";
            begin
            end;
        }
        field(38; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(39; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(40; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(42; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(43; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(44; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(45; "VAT Posting"; Option)
        {
            Caption = 'VAT Posting';
            Editable = false;
            OptionCaption = 'Automatic VAT Entry,Manual VAT Entry';
            OptionMembers = "Automatic VAT Entry","Manual VAT Entry";
        }
        field(47; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(48; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';
        }
        field(50; "Business Unit Code"; Code[10])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
        }
        field(51; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(52; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(53; "Recurring Method"; Option)
        {
            BlankZero = true;
            Caption = 'Recurring Method';
            OptionCaption = ' ,F  Fixed,V  Variable,B  Balance,RF Reversing Fixed,RV Reversing Variable,RB Reversing Balance';
            OptionMembers = " ","F  Fixed","V  Variable","B  Balance","RF Reversing Fixed","RV Reversing Variable","RB Reversing Balance";
        }
        field(54; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(55; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency';
        }
        field(56; "Allocated Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Gen. Jnl. Allocation".Amount where("Journal Template Name" = field("Journal Template Name"),
                                                                   "Journal Batch Name" = field("Journal Batch Name"),
                                                                   "Journal Line No." = field("Line No.")));
            Caption = 'Allocated Amt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(58; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(59; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(60; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(61; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
            Editable = false;
        }
        field(62; "Allow Application"; Boolean)
        {
            Caption = 'Allow Application';
            InitValue = true;
        }
        field(63; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(64; "Bal. Gen. Posting Type"; Option)
        {
            Caption = 'Bal. Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(65; "Bal. Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Bal. Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(66; "Bal. Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Bal. Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(67; "Bal. VAT Calculation Type"; Option)
        {
            Caption = 'Bal. VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(68; "Bal. VAT %"; Decimal)
        {
            Caption = 'Bal. VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(69; "Bal. VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Amount';
        }
        field(70; "Bank Payment Type"; Option)
        {
            Caption = 'Bank Payment Type';
            OptionCaption = ' ,Computer Check,Manual Check';
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(71; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
        }
        field(72; "Bal. VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Base Amount';
        }
        field(73; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(75; "Check Printed"; Boolean)
        {
            Caption = 'Check Printed';
            Editable = false;
        }
        field(76; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
        }
        field(77; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(78; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(79; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else
            if ("Source Type" = const(Vendor)) Vendor
            else
            if ("Source Type" = const("Bank Account")) "Bank Account"
            else
            if ("Source Type" = const("Fixed Asset")) "Fixed Asset";
        }
        field(80; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(82; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(83; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(84; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(85; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
        }
        field(86; "Bal. Tax Area Code"; Code[20])
        {
            Caption = 'Bal. Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(87; "Bal. Tax Liable"; Boolean)
        {
            Caption = 'Bal. Tax Liable';
        }
        field(88; "Bal. Tax Group Code"; Code[10])
        {
            Caption = 'Bal. Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(89; "Bal. Use Tax"; Boolean)
        {
            Caption = 'Bal. Use Tax';
        }
        field(90; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(91; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(92; "Bal. VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'Bal. VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(93; "Bal. VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'Bal. VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(95; "Additional-Currency Posting"; Option)
        {
            Caption = 'Additional-Currency Posting';
            Editable = false;
            OptionCaption = 'None,Amount Only,Additional-Currency Amount Only';
            OptionMembers = "None","Amount Only","Additional-Currency Amount Only";
        }
        field(98; "FA Add.-Currency Factor"; Decimal)
        {
            Caption = 'FA Add.-Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(99; "Source Currency Code"; Code[10])
        {
            Caption = 'Source Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(100; "Source Currency Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Currency Amount';
            Editable = false;
        }
        field(101; "Source Curr. VAT Base Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Curr. VAT Base Amount';
            Editable = false;
        }
        field(102; "Source Curr. VAT Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Curr. VAT Amount';
            Editable = false;
        }
        field(103; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(104; "VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Amount (LCY)';
            Editable = false;
        }
        field(105; "VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Base Amount (LCY)';
            Editable = false;
        }
        field(106; "Bal. VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bal. VAT Amount (LCY)';
            Editable = false;
        }
        field(107; "Bal. VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bal. VAT Base Amount (LCY)';
            Editable = false;
        }
        field(108; "Reversing Entry"; Boolean)
        {
            Caption = 'Reversing Entry';
            Editable = false;
        }
        field(109; "Allow Zero-Amount Posting"; Boolean)
        {
            Caption = 'Allow Zero-Amount Posting';
            Editable = false;
        }
        field(110; "Ship-to/Order Address Code"; Code[10])
        {
            Caption = 'Ship-to/Order Address Code';
            TableRelation = if ("Account Type" = const(Customer)) "Ship-to Address".Code where("Customer No." = field("Bill-to/Pay-to No."))
            else
            if ("Account Type" = const(Vendor)) "Order Address".Code where("Vendor No." = field("Bill-to/Pay-to No."))
            else
            if ("Bal. Account Type" = const(Customer)) "Ship-to Address".Code where("Customer No." = field("Bill-to/Pay-to No."))
            else
            if ("Bal. Account Type" = const(Vendor)) "Order Address".Code where("Vendor No." = field("Bill-to/Pay-to No."));
        }
        field(111; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(112; "Bal. VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Difference';
            Editable = false;
        }
        field(113; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(114; "IC Direction"; Option)
        {
            Caption = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
        }
        field(116; "IC Partner G/L Acc. No."; Code[20])
        {
            Caption = 'IC Partner G/L Acc. No.';
            TableRelation = "IC G/L Account";

            trigger OnValidate()
            var
                ICGLAccount: Record "IC G/L Account";
            begin
            end;
        }
        field(117; "IC Partner Transaction No."; Integer)
        {
            Caption = 'IC Partner Transaction No.';
            Editable = false;
        }
        field(118; "Sell-to/Buy-from No."; Code[20])
        {
            Caption = 'Sell-to/Buy-from No.';
            TableRelation = if ("Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor;
        }
        field(119; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
            end;
        }
        field(120; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(121; Prepayment; Boolean)
        {
            Caption = 'Prepayment';
        }
        field(122; "Financial Void"; Boolean)
        {
            Caption = 'Financial Void';
            Editable = false;
        }
        field(165; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';

            trigger OnValidate()
            var
                IncomingDocument: Record "Incoming Document";
            begin
            end;
        }
        field(170; "Creditor No."; Code[20])
        {
            Caption = 'Creditor No.';
            Numeric = true;
        }
        field(171; "Payment Reference"; Code[50])
        {
            Caption = 'Payment Reference';
            Numeric = true;
        }
        field(172; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(173; "Applies-to Ext. Doc. No."; Code[35])
        {
            Caption = 'Applies-to Ext. Doc. No.';
        }
        field(288; "Recipient Bank Account"; Code[10])
        {
            Caption = 'Recipient Bank Account';
            TableRelation = if ("Account Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Account No."))
            else
            if ("Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Account No."))
            else
            if ("Bal. Account Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Bal. Account No."))
            else
            if ("Bal. Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Bal. Account No."));
        }
        field(289; "Message to Recipient"; Text[70])
        {
            Caption = 'Message to Recipient';
        }
        field(290; "Exported to Payment File"; Boolean)
        {
            Caption = 'Exported to Payment File';
            Editable = false;
        }
        field(291; "Has Payment Export Error"; Boolean)
        {
            CalcFormula = exist("Payment Jnl. Export Error Text" where("Journal Template Name" = field("Journal Template Name"),
                                                                        "Journal Batch Name" = field("Journal Batch Name"),
                                                                        "Journal Line No." = field("Line No.")));
            Caption = 'Has Payment Export Error';
            Editable = false;
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(827; "Credit Card No."; Code[20])
        {
            Caption = 'Credit Card No.';
            // TableRelation = if ("Account Type" = const(Customer),
            //                     "Document Type" = filter(Payment | Refund),
            //                     "Bal. Account Type" = const("Bank Account")) "DO Payment Credit Card" where("Customer No." = field("Account No."));

            trigger OnValidate()
            var
                DOPaymentMgt: Codeunit "Sales Post Invoice Events";
            begin
            end;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(1002; "Job Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Job Unit Price (LCY)';
            Editable = false;
        }
        field(1003; "Job Total Price (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Job Total Price (LCY)';
            Editable = false;
        }
        field(1004; "Job Quantity"; Decimal)
        {
            Caption = 'Job Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(1005; "Job Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Job Unit Cost (LCY)';
            Editable = false;
        }
        field(1006; "Job Line Discount %"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Job Line Discount %';
        }
        field(1007; "Job Line Disc. Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Job Line Disc. Amount (LCY)';
            Editable = false;
        }
        field(1008; "Job Unit Of Measure Code"; Code[10])
        {
            Caption = 'Job Unit Of Measure Code';
            TableRelation = "Unit of Measure";
        }
        field(1009; "Job Line Type"; Option)
        {
            Caption = 'Job Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(1010; "Job Unit Price"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 2;
            Caption = 'Job Unit Price';
        }
        field(1011; "Job Total Price"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Total Price';
            Editable = false;
        }
        field(1012; "Job Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 2;
            Caption = 'Job Unit Cost';
            Editable = false;
        }
        field(1013; "Job Total Cost"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Total Cost';
            Editable = false;
        }
        field(1014; "Job Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Line Discount Amount';
        }
        field(1015; "Job Line Amount"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Line Amount';
        }
        field(1016; "Job Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Job Total Cost (LCY)';
            Editable = false;
        }
        field(1017; "Job Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Job Line Amount (LCY)';
            Editable = false;
        }
        field(1018; "Job Currency Factor"; Decimal)
        {
            Caption = 'Job Currency Factor';
        }
        field(1019; "Job Currency Code"; Code[10])
        {
            Caption = 'Job Currency Code';
        }
        field(1020; "Job Planning Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Job Planning Line No.';

            trigger OnLookup()
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;

            trigger OnValidate()
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;
        }
        field(1030; "Job Remaining Qty."; Decimal)
        {
            Caption = 'Job Remaining Qty.';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;
        }
        field(1200; "Direct Debit Mandate ID"; Code[35])
        {
            Caption = 'Direct Debit Mandate ID';
            TableRelation = if ("Account Type" = const(Customer)) "SEPA Direct Debit Mandate" where("Customer No." = field("Account No."));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            begin
            end;
        }
        field(1220; "Posting Exch. Entry No."; Integer)
        {
            Caption = 'Posting Exch. Entry No.';
            Editable = false;
        }
        field(1221; "Payer Information"; Text[50])
        {
            Caption = 'Payer Information';
        }
        field(1222; "Transaction Information"; Text[100])
        {
            Caption = 'Transaction Information';
        }
        field(1223; "Posting Exch. Line No."; Integer)
        {
            Caption = 'Posting Exch. Line No.';
            Editable = false;
        }
        field(1224; "Applied Automatically"; Boolean)
        {
            Caption = 'Applied Automatically';
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
        }
        field(5400; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            Editable = false;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
        }
        field(5601; "FA Posting Type"; Option)
        {
            Caption = 'FA Posting Type';
            OptionCaption = ' ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance';
            OptionMembers = " ","Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
        }
        field(5603; "Salvage Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Salvage Value';
        }
        field(5604; "No. of Depreciation Days"; Integer)
        {
            BlankZero = true;
            Caption = 'No. of Depreciation Days';
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
        }
        field(5606; "Depr. Acquisition Cost"; Boolean)
        {
            Caption = 'Depr. Acquisition Cost';
        }
        field(5609; "Maintenance Code"; Code[10])
        {
            Caption = 'Maintenance Code';
            TableRelation = Maintenance;
        }
        field(5610; "Insurance No."; Code[20])
        {
            Caption = 'Insurance No.';
            TableRelation = Insurance;
        }
        field(5611; "Budgeted FA No."; Code[20])
        {
            Caption = 'Budgeted FA No.';
            TableRelation = "Fixed Asset";
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List';
        }
        field(5614; "FA Reclassification Entry"; Boolean)
        {
            Caption = 'FA Reclassification Entry';
        }
        field(5615; "FA Error Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'FA Error Entry No.';
            TableRelation = "FA Ledger Entry";
        }
        field(5616; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
        }
        field(5617; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
        }
        field(5618; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(13701; "Source Curr. Excise Amount"; Decimal)
        {
            Caption = 'Source Curr. Excise Amount';
            Editable = false;
        }
        field(13702; "Source Curr. Tax Amount"; Decimal)
        {
            Caption = 'Source Curr. Tax Amount';
            Editable = false;
        }
        field(13703; "State Code"; Code[10])
        {
            Caption = 'State Code';
        }
        field(13706; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
        }
        field(13707; "Excise Prod. Posting Group"; Code[10])
        {
            Caption = 'Excise Prod. Posting Group';
        }
        field(13708; "Excise Amount"; Decimal)
        {
            Caption = 'Excise Amount';
            Editable = false;
        }
        field(13709; "BED %"; Decimal)
        {
            Caption = 'BED %';
            Editable = false;
        }
        field(13710; "BED Calculation Type"; Option)
        {
            Caption = 'BED Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit,% of MRP';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit","% of MRP";
        }
        field(13711; "Amount Including Excise"; Decimal)
        {
            Caption = 'Amount Including Excise';
            Editable = false;
        }
        field(13712; "Excise Base Amount"; Decimal)
        {
            Caption = 'Excise Base Amount';
            Editable = false;
        }
        field(13716; "TDS/TCS Amount"; Decimal)
        {
            Caption = 'TDS/TCS Amount';
            Editable = false;
        }
        field(13717; "Service Tax"; Decimal)
        {
            Caption = 'Service Tax';
        }
        field(13718; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
            DecimalPlaces = 0 : 4;
        }
        field(13736; PLA; Boolean)
        {
            Caption = 'PLA';
        }
        field(13737; "Tax %"; Decimal)
        {
            Caption = 'Tax %';
        }
        field(13744; "Tax Base Amount"; Decimal)
        {
            Caption = 'Tax Base Amount';
        }
        field(13746; Cenvat; Boolean)
        {
            Caption = 'Cenvat';
        }
        field(13747; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(13750; "Source Curr. Tax Base Amount"; Decimal)
        {
            Caption = 'Source Curr. Tax Base Amount';
            Editable = false;
        }
        field(13753; "Tax Amount (LCY)"; Decimal)
        {
            Caption = 'Tax Amount (LCY)';
        }
        field(13754; "Tax Base Amount (LCY)"; Decimal)
        {
            Caption = 'Tax Base Amount (LCY)';
        }
        field(13758; "TDS Nature of Deduction"; Code[10])
        {
            Caption = 'TDS Nature of Deduction';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
                Location: Record Location;
            begin
            end;
        }
        field(13759; "Assessee Code"; Code[10])
        {
            Caption = 'Assessee Code';
            Editable = false;
        }
        field(13760; "TDS/TCS %"; Decimal)
        {
            Caption = 'TDS/TCS %';
            Editable = false;
        }
        field(13761; "TDS/TCS Amt Incl Surcharge"; Decimal)
        {
            Caption = 'TDS/TCS Amt Incl Surcharge';
            Editable = false;
        }
        field(13763; "Bal. TDS/TCS Including SHECESS"; Decimal)
        {
            Caption = 'Bal. TDS/TCS Including SHECESS';
            Editable = false;
        }
        field(13764; "Party Type"; Option)
        {
            BlankNumbers = DontBlank;
            Caption = 'Party Type';
            InitValue = " ";
            OptionCaption = ' ,Party,Customer,Vendor';
            OptionMembers = " ",Party,Customer,Vendor;
        }
        field(13765; "Party Code"; Code[20])
        {
            Caption = 'Party Code';
        }
        field(13773; "Form Code"; Code[10])
        {
            Caption = 'Form Code';
        }
        field(13774; "Form No."; Code[10])
        {
            Caption = 'Form No.';
        }
        field(13779; "LC No."; Code[20])
        {
            Caption = 'LC No.';
        }
        field(13780; "Work Tax Base Amount"; Decimal)
        {
            Caption = 'Work Tax Base Amount';
            Editable = true;
        }
        field(13781; "Work Tax %"; Decimal)
        {
            Caption = 'Work Tax %';
            Editable = false;
        }
        field(13782; "Work Tax Amount"; Decimal)
        {
            Caption = 'Work Tax Amount';
            Editable = false;
        }
        field(13786; "TDS Category"; Option)
        {
            Caption = 'TDS Category';
            OptionCaption = ' ,A,C,S,T';
            OptionMembers = " ",A,C,S,T;
        }
        field(13787; "Surcharge %"; Decimal)
        {
            Caption = 'Surcharge %';
            Editable = false;
        }
        field(13788; "Surcharge Amount"; Decimal)
        {
            Caption = 'Surcharge Amount';
            Editable = false;
        }
        field(13789; "Concessional Code"; Code[10])
        {
            Caption = 'Concessional Code';
            Editable = false;
        }
        field(13790; "Work Tax Paid"; Boolean)
        {
            Caption = 'Work Tax Paid';
            Editable = false;
        }
        field(50000; Description2; Text[50])
        {
            Caption = 'Description';
        }
        field(50001; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(50002; "Account Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Transaction No", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";


    procedure InitType()
    begin
        /*IF "Transaction No" <> '' THEN BEGIN
           "Account Type":=xRec."Account Type";
           "Bal. Account Type":=xRec."Bal. Account Type";
        END;
        */

    end;

    local procedure GetAccTypeAndNo(var AccType: Option; var AccNo: Code[20])
    begin
        /*IF "Bal. Account Type" IN
           ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor]
        THEN BEGIN
          AccType := "Bal. Account Type";
          AccNo := "Bal. Account No.";
        END ELSE BEGIN
          AccType := "Account Type";
          AccNo := "Account No.";
        END;
        */

    end;


    procedure LookUpAppliesToDocCust(AccNo: Code[20])
    var
        ApplyCustEntries: Page "Apply Customer Entries";
    begin
        /*
        CLEAR(CustLedgEntry);
        CustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive,"Due Date");
        IF AccNo <> '' THEN
          CustLedgEntry.SETRANGE("Customer No.",AccNo);
        IF "TDS Nature of Deduction" <> '' THEN
          CustLedgEntry.SETRANGE("TDS Nature of Deduction","TDS Nature of Deduction");
        IF "TDS Group" <> "TDS Group"::" " THEN
          CustLedgEntry.SETRANGE("TDS Group","TDS Group");
        CustLedgEntry.SETRANGE(Open,TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
          CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF CustLedgEntry.ISEMPTY THEN BEGIN
            CustLedgEntry.SETRANGE("Document Type");
            CustLedgEntry.SETRANGE("Document No.");
          END;
        END;
        IF "Applies-to ID" <> '' THEN BEGIN
          CustLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
          IF CustLedgEntry.ISEMPTY THEN
            CustLedgEntry.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
          CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          IF CustLedgEntry.ISEMPTY THEN
            CustLedgEntry.SETRANGE("Document Type");
        END;
        IF Amount <> 0 THEN BEGIN
          CustLedgEntry.SETRANGE(Positive,Amount < 0);
          IF CustLedgEntry.ISEMPTY THEN
            CustLedgEntry.SETRANGE(Positive);
        END;
        ApplyCustEntries.SetGenJnlLine(Rec,GenJnlLine.FIELDNO("Applies-to Doc. No."));
        ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
        ApplyCustEntries.SETRECORD(CustLedgEntry);
        ApplyCustEntries.LOOKUPMODE(TRUE);
        IF ApplyCustEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ApplyCustEntries.GETRECORD(CustLedgEntry);
          IF AccNo = '' THEN BEGIN
            AccNo := CustLedgEntry."Customer No.";
            IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
              VALIDATE("Bal. Account No.",AccNo)
            ELSE
              VALIDATE("Account No.",AccNo);
          END;
          IF "Currency Code" <> CustLedgEntry."Currency Code" THEN
            IF Amount = 0 THEN BEGIN
              FromCurrencyCode := GetShowCurrencyCode("Currency Code");
              ToCurrencyCode := GetShowCurrencyCode(CustLedgEntry."Currency Code");
              IF NOT
                 CONFIRM(
                   Text003,TRUE,FIELDCAPTION("Currency Code"),TABLECAPTION,FromCurrencyCode,ToCurrencyCode)
              THEN
                ERROR(Text005);
              VALIDATE("Currency Code",CustLedgEntry."Currency Code");
            END ELSE
              GenJnlApply.CheckAgainstApplnCurrency(
                "Currency Code",CustLedgEntry."Currency Code",
                GenJnlLine."Account Type"::Customer,TRUE);
          IF Amount = 0 THEN BEGIN
            CustLedgEntry.CALCFIELDS("Remaining Amount");
            IF CustLedgEntry."Amount to Apply" <> 0 THEN BEGIN
              IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(Rec,CustLedgEntry,0,FALSE) THEN BEGIN
                IF ABS(CustLedgEntry."Amount to Apply") >=
                   ABS(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                THEN
                  Amount := -(CustLedgEntry."Remaining Amount" -
                              CustLedgEntry."Remaining Pmt. Disc. Possible")
                ELSE
                  Amount := -CustLedgEntry."Amount to Apply";
              END ELSE
                Amount := -CustLedgEntry."Amount to Apply";
            END ELSE BEGIN
              IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(Rec,CustLedgEntry,0,FALSE) THEN
                Amount := -(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")
              ELSE
                Amount := -CustLedgEntry."Remaining Amount";
            END;
            IF "Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor] THEN
              Amount := -Amount;
            VALIDATE(Amount);
          END;
          "Applies-to Doc. Type" := CustLedgEntry."Document Type";
          "Applies-to Doc. No." := CustLedgEntry."Document No.";
          "Applies-to ID" := '';
        END;
        "Transaction No. Serv. Tax" := 0;
        IF CustLedgEntry."Serv. Tax on Advance Payment" THEN BEGIN
          "Transaction No. Serv. Tax" := CustLedgEntry."Transaction No.";
          ServTaxEntry.RESET;
          ServTaxEntry.SETRANGE("Transaction No.",CustLedgEntry."Transaction No.");
          IF ServTaxEntry.FINDFIRST THEN BEGIN
            "Service Tax Rounding Precision" := ServTaxEntry."Service Tax Rounding Precision";
            "Service Tax Rounding Type" := ServTaxEntry."Service Tax Rounding Type";
          END;
        END;
        
        GetCreditCard;
        */

    end;


    procedure LookUpAppliesToDocVend(AccNo: Code[20])
    var
        ApplyVendEntries: Page "Apply Vendor Entries";
    begin
        /*CLEAR(VendLedgEntry);
        VendLedgEntry.SETCURRENTKEY("Vendor No.",Open,Positive,"Due Date");
        IF AccNo <> '' THEN
          VendLedgEntry.SETRANGE("Vendor No.",AccNo);
        VendLedgEntry.SETRANGE(Open,TRUE);
        IF "TDS Nature of Deduction" <> '' THEN
          VendLedgEntry.SETRANGE("TDS Nature of Deduction","TDS Nature of Deduction");
        IF "TDS Group" <> "TDS Group"::" " THEN
          VendLedgEntry.SETRANGE("TDS Group","TDS Group");
        IF "Applies-to Doc. No." <> '' THEN BEGIN
          VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF VendLedgEntry.ISEMPTY THEN BEGIN
            VendLedgEntry.SETRANGE("Document Type");
            VendLedgEntry.SETRANGE("Document No.");
          END;
        END;
        IF "Applies-to ID" <> '' THEN BEGIN
          VendLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
          IF VendLedgEntry.ISEMPTY THEN
            VendLedgEntry.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
          VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          IF VendLedgEntry.ISEMPTY THEN
            VendLedgEntry.SETRANGE("Document Type");
        END;
        
        IF  "Applies-to Doc. No." <> ''THEN BEGIN
          VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF VendLedgEntry.ISEMPTY THEN
            VendLedgEntry.SETRANGE("Document No.");
        END;
        IF Amount <> 0 THEN BEGIN
          VendLedgEntry.SETRANGE(Positive,Amount < 0);
          IF VendLedgEntry.ISEMPTY THEN;
          VendLedgEntry.SETRANGE(Positive);
        END;
        ApplyVendEntries.SetGenJnlLine2(Rec,FIELDNO("Applies-to Doc. No."));
        ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
        ApplyVendEntries.SETRECORD(VendLedgEntry);
        ApplyVendEntries.LOOKUPMODE(TRUE);
        IF ApplyVendEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ApplyVendEntries.GETRECORD(VendLedgEntry);
          IF AccNo = '' THEN BEGIN
            AccNo := VendLedgEntry."Vendor No.";
            IF "Bal. Account Type" = "Bal. Account Type"::Vendor THEN
              VALIDATE("Bal. Account No.",AccNo)
            ELSE
              VALIDATE("Account No.",AccNo);
          END;
        
          "Applies-to Doc. Type" := VendLedgEntry."Document Type";
          "Applies-to Doc. No." := VendLedgEntry."Document No.";
          "Applies-to ID" := '';
        END;
        "Transaction No. Serv. Tax" := 0;
        IF VendLedgEntry."Serv. Tax on Advance Payment" THEN BEGIN
          "Transaction No. Serv. Tax" := VendLedgEntry."Transaction No.";
          ServTaxEntry.RESET;
          ServTaxEntry.SETRANGE("Transaction No.",VendLedgEntry."Transaction No.");
          IF ServTaxEntry.FINDFIRST THEN BEGIN
            "Service Tax Rounding Precision" := ServTaxEntry."Service Tax Rounding Precision";
            "Service Tax Rounding Type" := ServTaxEntry."Service Tax Rounding Type";
          END;
        END;
        
        VALIDATE("Applies-to Doc. No.");
        */

    end;


    procedure TestStatusOpen()
    var
        AcctOrdHeaderRec: Record "Accounting Voucher Header";
    begin
        /*IF "Transaction No"<>'' THEN BEGIN
          AcctOrdHeaderRec.RESET;
          AcctOrdHeaderRec.SETRANGE(AcctOrdHeaderRec."Transaction No","Transaction No");
          IF AcctOrdHeaderRec.FINDFIRST THEN
            AcctOrdHeaderRec.TESTFIELD(AcctOrdHeaderRec.Status,AcctOrdHeaderRec.Status::Open);
        END;
        */

    end;
}

