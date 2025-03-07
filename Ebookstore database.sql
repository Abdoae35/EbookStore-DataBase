USE EbookStore;

CREATE TABLE Client
(
	Client_Id INT PRIMARY KEY IDENTITY,
	FullName NVARCHAR(255) NOT NULL,
	Email NVARCHAR(255) UNIQUE NOT NULL,
	[Password] NVARCHAR(50) NOT NULL,
	Phone NVARCHAR(50) NULL,
	DateOfCreation DATETIME DEFAULT GETDATE()
)

CREATE TABLE Seller
(
	Seller_Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(255) NOT NULL,
	Email NVARCHAR(255) UNIQUE NOT NULL,
	Store_name NVARCHAR(255) NULL,
	DateOfCreation DATETIME DEFAULT GETDATE()
)

CREATE TABLE [Admin]
(	
	Admin_Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(255) NOT NULL,
	Email NVARCHAR(255) UNIQUE NOT NULL,
	[Password] NVARCHAR(255) NOT NULL
)

CREATE TABLE Books
(
	BookID INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(255) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	Price DECIMAL(10,2) NOT NULL,
	Category NVARCHAR(200) NULL,
	Seller_Id INT NOT NULL,
	UploadTime DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (Seller_Id) REFERENCES Seller(Seller_Id) ON DELETE CASCADE
)


CREATE TABLE Orders
(
	OrderId INT PRIMARY KEY IDENTITY,
	Client_Id INT NOT NULL,
	TotalAmount DECIMAL(10,2) NOT NULL,
	OrderStatus NVARCHAR(20) CHECK (OrderStatus	IN ('Pending','Complete','Cancelled')) DEFAULT 'Pending',
	OrderDate DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (Client_Id) REFERENCES Client(Client_Id) ON DELETE CASCADE
)
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    Client_Id INT NOT NULL,
    BookID INT NOT NULL,
    Quantity INT DEFAULT 1,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE NO ACTION,
    FOREIGN KEY (Client_Id) REFERENCES Client(Client_Id) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);

CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT UNIQUE NOT NULL,
    PaymentMethod NVARCHAR(50) CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Crypto')) NOT NULL,
    PaymentStatus NVARCHAR(20) CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed')) DEFAULT 'Pending',
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
);
CREATE TABLE Wishlist (
    WishlistID INT IDENTITY(1,1) PRIMARY KEY,
    Client_ID INT NOT NULL,
    BookID INT NOT NULL,
    AddedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Client_ID) REFERENCES Client(Client_Id) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);

CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    Client_ID INT NOT NULL,
    BookID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
    ReviewText NVARCHAR(MAX) NULL,
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Client_ID) REFERENCES Client(Client_Id) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);