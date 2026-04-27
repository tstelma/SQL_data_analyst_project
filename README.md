# 📊 Data Analyst Skills Market Analysis (SQL Project)

## 📌 Project Overview

This project analyzes the **Data Analyst job market** using SQL, focusing on identifying the most valuable skills based on:

* 📈 Demand
* 💰 Salary
* 📊 Market trends over time
* 🤝 Skill relationships

The goal is to move beyond simple queries and deliver **insight-driven conclusions** about which skills matter most and why.

To display the SQL queries click here: [project_sql folder](/project_sql/)

---

## 🗂️ Dataset

The analysis is based on a dataset containing:

- Job postings
- Associated skills
- Salary information
- Job metadata (title, location, etc.)

📌 **Data Source**  
This dataset was provided by Luke Barousse, founder of Data Nerd Tech — a platform that collects and analyzes job postings in the data field using web scraping.

🔗 https://datanerd.tech/

---

## 🔍 Key Questions Answered

1. What are the **top-paying Data Analyst jobs**?
2. Which skills are associated with the **highest salaries**?
3. What are the **most in-demand skills**?
4. Which skills provide the best **balance of demand and salary**?
5. Which skills **frequently appear together**?
6. How does skill demand change **over time**?
7. Which skills are **growing or declining (YoY trends)**?
8. What is the **optimal skill strategy** for a Data Analyst?

---

## 🧠 Project Structure

| Step | File                                   | Description                                         |
| ---- | -------------------------------------- | --------------------------------------------------- |
| 1    | `1_top_paying_jobs.sql`                | Identifies highest-paying remote Data Analyst roles |
| 2    | `2_top_paying_skills.sql`              | Extracts skills from top-paying jobs                |
| 3    | `3_top_demanded_skills.sql`            | Finds most in-demand skills                         |
| 4    | `4_most_optimal_skills.sql`            | Combines demand and salary insights                 |
| 5    | `5_skill_complementarity.sql`          | Analyzes which skills appear together               |
| 6    | `6_skills_over_time.sql`               | Tracks skill demand trends by year                  |
| 7    | `7_skills_YoY_growth.sql`              | Calculates year-over-year demand changes            |
| 8    | `8_ultimate_skills_classification.sql` | Final skill strategy classification                 |

---

## 📈 Key Insights

### 🔹 Core Skills (Must-Have)
- SQL and Excel consistently dominate job postings across all years
- These skills form the **foundation of nearly every Data Analyst role**
- While highly demanded, they act more as **entry requirements than differentiators**

| Skill      | Demand Count |
|------------|-------------|
| SQL        | 10,641      |
| Excel      | 8,716       |
| Python     | 7,064       |
| Tableau    | 5,842       |
| Power BI   | 4,620       |

---

### 🔹 High-Value Analyst Stack
- Python, Tableau, and Power BI provide the strongest balance of:
  - Demand
  - Salary potential
  - Market relevance
- These tools enable both **data manipulation and visualization**, making them critical for end-to-end analysis

| Skill     | Demand Count | Avg Salary ($) | Combined Score |
|----------|-------------|----------------|----------------|
| Python   | 508         | 98,671         | 266.99         |
| Tableau  | 500         | 100,093        | 270.15         |
| Power BI | 280         | 91,958         | 225.04         |

---

### 🔹 Modern Data Platform Skills (Rising Value)
- Tools like Snowflake, Databricks, Azure, and AWS show:
  - Increasing demand over time
  - Higher-than-average salary associations
- Indicates a shift toward **cloud-based and scalable data infrastructure**

| Skill       | Demand Count | Avg Salary ($) | YoY Trend |
|------------|-------------|----------------|-----------|
| Snowflake  | 78          | 106,715        | ↑ Growing |
| Databricks | 41          | 117,633        | ↑ Strong Growth |
| Azure      | 72          | 99,153         | ↗ Recovery / Growth |
| AWS        | 79          | 88,213         | ↓ Slight Decline |
---

### 🔹 Declining / Shifting Tools
- R and SAS show a **decline in relative demand (YoY)**
- Still relevant in specific industries, but gradually being replaced by:
  - Python (for flexibility)
  - Modern data platforms

| Skill | 2023 Demand Ratio | 2024 Demand Ratio | 2025 Demand Ratio | Trend |
|------|-------------------|-------------------|-------------------|-------|
| R    | 0.1971            | 0.1586            | 0.1396            | ↓ Declining |
| SAS  | 0.1837            | 0.1318            | 0.1238            | ↓ Declining |

---

### 🔹 Skill Complementarity Trends
- The most common and valuable skill combinations include:
  - SQL + Python
  - SQL + Tableau / Power BI
  - Python + R
- Suggests that employers prioritize **skill stacks rather than single tools**

| Skill 1 | Skill 2   | Pair Count |
|--------|-----------|------------|
| SQL    | Python    | 5,427      |
| SQL    | Tableau   | 4,472      |
| SQL    | Excel     | 4,189      |
| SQL    | Power BI  | 3,432      |
| Python | R         | 3,340      |
| Python | Tableau   | 3,103      |

---

### 🔹 Market Trend Over Time
- Overall job postings increased significantly (2023 → 2025)
- Relative demand (normalized) shows:
- Slight decline in traditional tools (SQL, Excel dominance shrinking)
- Growth in specialized and platform-based skills
- Reflects a transition from **basic analytics → modern data ecosystems**

Overall number of Data Analyst job postings by year:

| Year | Total Job Postings |
|------|-------------------|
| 2023 | 5,465             |
| 2024 | 5,979             |
| 2025 | 12,661            |

Key skill demand trends (normalized by total postings):

| Skill   | 2023 Ratio | 2024 Ratio | 2025 Ratio | Trend |
|--------|------------|------------|------------|--------|
| SQL    | 0.5641     | 0.4320     | 0.3929     | ↓ Declining dominance |
| Excel  | 0.3919     | 0.4700     | 0.2973     | ⚠ Volatile / declining |
| Python | 0.3367     | 0.3039     | 0.2691     | ↓ Slight decline |
| Power BI | 0.1910   | 0.1828     | 0.1961     | ↗ Stable / slight growth |
| Databricks | 0.0185 | 0.0249     | 0.0316     | ↑ Strong growth |

---

### 🔹 Strategic Takeaway
- The most effective Data Analyst profile combines:
  1. **Core foundation** (SQL, Excel)
  2. **Analytical + visualization tools** (Python, BI tools)
  3. **Modern data platform exposure** (cloud / big data tools)
### 📊 Strategic Skill Framework

| Layer | Skill Category | Key Tools | Strategic Role |
|------|----------------|-----------|----------------|
| 1️⃣ Foundation | Core Skills | SQL, Excel | Essential baseline required in most roles |
| 2️⃣ Analytical Stack | Analysis & Visualization | Python, Tableau, Power BI | Enables data processing, analysis, and storytelling |
| 3️⃣ Modern Platforms | Data Infrastructure | Snowflake, Databricks, Azure, AWS | Supports scalable, cloud-based data environments |

👉 The market increasingly rewards **well-rounded, stack-oriented skillsets** over isolated expertise.

---

## 🛠️ Tools Used

### 🔹 SQL (PostgreSQL)
- Built complex queries using:
  - JOINs, CTEs and subqueries
- Performed data cleaning, aggregation, and transformation
- Conducted advanced analysis including:
  - Skill demand ranking
  - Salary analysis
  - Year-over-year trend calculations
  - Skill co-occurrence (complementarity) analysis
### 🔹 VS Code
- Developed and organized SQL scripts in a structured project format
- Managed multiple analysis files for different problem areas
- Improved workflow efficiency using extensions and integrated terminal
### 🔹 Git & GitHub
- Version control for tracking project progress
- Managed commits, file structure, and repository organization
- Learned how to:
  - Stage, commit, and push changes
  - Use `.gitignore` to manage tracked files
  - Maintain a clean and professional project repository

---

## 🎯 Final Conclusion

The most effective Data Analyst skill strategy is:

1. Build a strong **foundation** (SQL + Excel)
2. Add a **high-value analytics stack** (Python + BI tools)
3. Specialize in **modern data platforms** (e.g., Snowflake, Databricks)

👉 Success in the field depends on combining **core skills with modern technologies**, rather than relying on a single tool.

---

## 🚀 Future Improvements

* Build interactive dashboards (Power BI / Tableau)
* Add visualizations for time trends
* Expand analysis to other roles (Data Scientist, Data Engineer)

---

## 👤 Author

**Tomasz Stelmaszczyk**

---

## 🙏 Acknowledgments

Special thanks to Luke Barousse (datanerd.tech) for providing the dataset used in this analysis.

## ⭐ If you found this useful

Feel free to star the repository or connect!

