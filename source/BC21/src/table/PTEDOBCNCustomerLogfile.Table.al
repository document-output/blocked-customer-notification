table 61200 "PTE DO BCN Customer Logfile"
{
    Caption = 'PTE DO BCN Customer Logfile';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Log Entry No."; Integer)
        {
            Caption = 'Log Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(5; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(6; "Old Blocked Status"; Enum "Customer Blocked")
        {
            Caption = 'Old Blocked Status';
            DataClassification = CustomerContent;
        }
        field(7; "New Blocked Status"; Enum "Customer Blocked")
        {
            Caption = 'New Blocked Status';
            DataClassification = CustomerContent;
        }
        field(10; "Changed Timestamp"; DateTime)
        {
            Caption = 'Changed Timestamp';
            DataClassification = CustomerContent;
        }
        field(11; "Changed by User"; Code[50])
        {
            Caption = 'Changed by User';
            DataClassification = CustomerContent;
        }
        field(15; SalepersonCode; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Salesperson';
        }
    }
    keys
    {
        key(PK; "Log Entry No.")
        {
            Clustered = true;
        }
        key(SK; "Customer No.")
        {
        }
    }
}
