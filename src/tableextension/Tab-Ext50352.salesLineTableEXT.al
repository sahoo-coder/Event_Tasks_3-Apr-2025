tableextension 50352 salesLineTableEXT extends "Sales Line"
{
    fields
    {
        // Add changes to table fields here
        field(50900; SO_Line_KSS; Text[100])
        {
            Caption = 'Sales Line_KSS';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}