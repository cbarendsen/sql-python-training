# SQL Server and Python Training Environment

This environment runs in your web browser. It includes:

- **SQL Server 2025 Developer edition** with a sample database called **TrainingShop**
- **Visual Studio Code** with the SQL Server (MSSQL) extension for writing and running queries
- **Python 3.12** with Jupyter notebooks, pandas and matplotlib

You do not need to install anything on your computer.

---

## 1. Start your environment

1. Sign in to your own free GitHub account.
2. On this project's page, select the green **Code** button, then the **Codespaces** tab, then **Create codespace on main**.
3. The first start takes about 5 minutes while SQL Server and Python are set up. Watch the terminal at the bottom. It shows **"Setup complete"** when it is ready.

Next time, return to <https://github.com/codespaces> and open your existing codespace. It starts in under a minute, and your work is still there.

## 2. Work with SQL Server

1. Select the **SQL Server** icon in the left-hand bar (it looks like a database barrel).
2. Select the connection **Training SQL Server**. If it asks for a password, enter `Training!Pass2026`.
3. Expand **Databases > TrainingShop > Tables** to see the tables.
4. Open `sql/02_practice_queries.sql`. Highlight a query and press **Ctrl+Shift+E** (Mac: **Cmd+Shift+E**) to run it. Results appear in a panel beside the query.

To reset the database to its original state at any time, open the terminal and run:

```bash
python .devcontainer/load_database.py
```

## 3. Work with Python

1. Open `notebooks/01_python_and_sql.ipynb`.
2. If asked to choose a kernel, choose **Python 3.12**.
3. Run each cell with **Shift+Enter**.

## 4. When you finish a session

Your codespace stops on its own after 30 minutes of inactivity. To stop it straight away, go to <https://github.com/codespaces>, select the three dots beside your codespace, then **Stop codespace**.

Each free GitHub account includes about 60 hours a month of codespace time. Stopping your codespace when you are not using it saves those hours.

## Connection details (for reference)

| Setting  | Value               |
|----------|---------------------|
| Server   | `localhost,1433`    |
| Login    | `sa`                |
| Password | `Training!Pass2026` |
| Database | `TrainingShop`      |

This password is for this training environment only. Never use it for real systems.
