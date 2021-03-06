CREATE TABLE IF NOT EXISTS BlockHeaders
(
	BlockHash BINARY(32) NOT NULL,
	HeaderBytes BINARY(80) NOT NULL,
	CONSTRAINT PK_BlockHeaders PRIMARY KEY
	(
		BlockHash ASC
	)
);

CREATE TABLE IF NOT EXISTS ChainedBlocks
(
	BlockHash BINARY(32) NOT NULL,
	PreviousBlockHash BINARY(32) NOT NULL,
	Height INT NOT NULL,
	TotalWork BINARY(64) NOT NULL,
	CONSTRAINT PK_ChainedBlocks PRIMARY KEY
	(
		BlockHash ASC
	)
);

CREATE TABLE IF NOT EXISTS KnownAddresses
(
	IPAddress BINARY(16) NOT NULL,
	Port BINARY(2) NOT NULL,
	Services BINARY(8) NOT NULL,
	Time BINARY(4) NOT NULL,
	CONSTRAINT PK_KnownAddresses PRIMARY KEY
	(
		IPAddress ASC,
		Port ASC
	)
);

CREATE TABLE IF NOT EXISTS BlockTransactions
(
	BlockHash BINARY(32) NOT NULL,
	TxIndex INTEGER NOT NULL,
	TxHash BINARY(32) NOT NULL,
	TxBytes VARBINARY(100000) NOT NULL,
	CONSTRAINT PK_BlockTransactions PRIMARY KEY
	(
		BlockHash,
		TxIndex
	)
);

--CREATE INDEX IF NOT EXISTS IX_BlockTransactions_BlockHash ON BlockTransactions ( BlockHash );

--CREATE INDEX IF NOT EXISTS IX_BlockTransactions_TxHash ON BlockTransactions ( TxHash );

CREATE TABLE IF NOT EXISTS BlockTransactionsChunked
(
	BlockHash BINARY(32) NOT NULL,
	MinTxIndex INTEGER NOT NULL,
	MaxTxIndex INTEGER NOT NULL,
	TxChunkBytes VARBINARY(1000000) NOT NULL,
	CONSTRAINT PK_BlockTransactionsChunked PRIMARY KEY
	(
		BlockHash,
		MinTxIndex
	),
	CONSTRAINT UQ_BlockTransactionsChunked_MaxTxIndex UNIQUE ( BlockHash, MaxTxIndex )
);
