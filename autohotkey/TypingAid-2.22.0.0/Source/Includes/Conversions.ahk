; these functions handle database conversion
; always set the SetDbVersion default argument to the current highest version

SetDbVersion(dBVersion = 3)
{
	global g_WordListDB
	g_WordListDB.Query("INSERT OR REPLACE INTO LastState VALUES ('databaseVersion', '" . dBVersion . "', NULL);")
}


; returns true if we need to rebuild the whole database
MaybeConvertDatabase()
{
	global g_WordListDB
	
	databaseVersionRows := g_WordListDB.Query("SELECT lastStateNumber FROM LastState WHERE lastStateItem = 'databaseVersion';")
	
	if (databaseVersionRows)
	{
		for each, row in databaseVersionRows.Rows
		{
			databaseVersion := row[1]
		}
	}
	
	if (!databaseVersion)
	{
		   tableConverted := g_WordListDB.Query("SELECT tableconverted FROM LastState;")
	} else {
		tableConverted := g_WordListDB.Query("SELECT lastStateNumber FROM LastState WHERE lastStateItem = 'tableConverted';")
	}
   
	if (tableConverted)
	{
		for each, row in tableConverted.Rows
		{
			WordlistConverted := row[1]
		}
	}
	
	IfNotEqual, WordlistConverted, 1
	{
		RebuildDatabase()		
		return, true
	}
	
	if (!databaseVersion)
	{
		RunConversionOne(WordlistConverted)
	}
	
	if (databaseVersion < 2)
	{
		RunConversionTwo()
	}
	
	if (databaseVersion < 3)
	{
		RunConversionThree()
	}
	
	return, false
}


; Rebuilds the Database from scratch as we have to redo the wordlist anyway.
RebuildDatabase()
{
	global g_WordListDB
	g_WordListDB.BeginTransaction()
	g_WordListDB.Query("DROP TABLE Words;")
	g_WordListDB.Query("DROP INDEX WordIndex;")
	g_WordListDB.Query("DROP TABLE LastState;")
	
	CreateWordsTable()
	
	CreateWordIndex()
	
	CreateLastStateTable()
	
	SetDbVersion()
	g_WordListDB.EndTransaction()
		
}

;Runs the first conversion
RunConversionOne(WordlistConverted)
{
	global g_WordListDB
	g_WordListDB.BeginTransaction()
	
	g_WordListDB.Query("ALTER TABLE LastState RENAME TO OldLastState;")
	
	CreateLastStateTable()
	
	g_WordListDB.Query("DROP TABLE OldLastState;")
	g_WordListDB.Query("INSERT OR REPLACE INTO LastState VALUES ('tableConverted', '" . WordlistConverted . "', NULL);")
	
	;superseded by conversion 3
	;g_WordListDB.Query("ALTER TABLE Words ADD COLUMN worddescription TEXT;")
	
	SetDbVersion(1)
	g_WordListDB.EndTransaction()
	
}

RunConversionTwo()
{
	global g_WordListDB
	
	;superseded by conversion 3
	;g_WordListDB.Query("ALTER TABLE Words ADD COLUMN wordreplacement TEXT;")
	
	;SetDbVersion(2)
}

RunConversionThree()
{
	global g_WordListDB
	g_WordListDB.BeginTransaction()
	
	CreateWordsTable("Words2")
	
	g_WordListDB.Query("UPDATE Words SET wordreplacement = '' WHERE wordreplacement IS NULL;")
	
	g_WordListDB.Query("INSERT INTO Words2 SELECT * FROM Words;")
	
	g_WordListDB.Query("DROP TABLE Words;")
	
	g_WordListDB.Query("ALTER TABLE Words2 RENAME TO Words;")
	
	CreateWordIndex()
	
	SetDbVersion(3)
	g_WordListDB.EndTransaction()
}

CreateLastStateTable()
{
	global g_WordListDB

	IF not g_WordListDB.Query("CREATE TABLE LastState (lastStateItem TEXT PRIMARY KEY, lastStateNumber INTEGER, otherInfo TEXT) WITHOUT ROWID;")
	{
		ErrMsg := g_WordListDB.ErrMsg()
		ErrCode := g_WordListDB.ErrCode()
		MsgBox Cannot Create LastState Table - fatal error: %ErrCode% - %ErrMsg%
		ExitApp
	}
}

CreateWordsTable(WordsTableName:="Words")
{
	global g_WordListDB
	
	IF not g_WordListDB.Query("CREATE TABLE " . WordsTableName . " (wordindexed TEXT NOT NULL, word TEXT NOT NULL, count INTEGER, worddescription TEXT, wordreplacement TEXT NOT NULL, PRIMARY KEY (word, wordreplacement) );")
	{
		ErrMsg := g_WordListDB.ErrMsg()
		ErrCode := g_WordListDB.ErrCode()
		msgbox Cannot Create %WordsTableName% Table - fatal error: %ErrCode% - %ErrMsg%
		ExitApp
	}
}

CreateWordIndex()
{
	global g_WordListDB

	IF not g_WordListDB.Query("CREATE INDEX WordIndex ON Words (wordindexed);")
	{
		ErrMsg := g_WordListDB.ErrMsg()
		ErrCode := g_WordListDB.ErrCode()
		msgbox Cannot Create WordIndex Index - fatal error: %ErrCode% - %ErrMsg%
		ExitApp
	}
}