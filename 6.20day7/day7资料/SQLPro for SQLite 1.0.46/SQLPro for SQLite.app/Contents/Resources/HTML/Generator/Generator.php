<?php
    error_reporting(E_ALL);
    include_once('libs/SQLiteProfessional.class.php');

    // Get our input
    // Get rid of our file.
    parse_str($argv[1], $_GET);
    print_r($_GET);

    // Get our settings from the input file
    $jsonString = file_get_contents($_GET['inputFile']);
    $data = json_decode($jsonString);
/*
    // Create our table
    $table = new SQLTable("testing");
    $table->addColumn('column one');
    
    $tables = array();
    array_push($tables, $table);

    $currentUser = 'Kyle Hankinson';
    $currentDate = 'August 12, 1985';

    // Loop through our tables
    foreach($tables as $table)
    {
        // Get the header
        include('templates/ModelHeader.php');
    } // End of tables loop
*/
?>