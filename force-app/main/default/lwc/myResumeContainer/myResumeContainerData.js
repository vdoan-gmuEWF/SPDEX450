import SOCIAL from '@salesforce/resourceUrl/SOCIAL';
import vdoan from '@salesforce/resourceUrl/vdoan';

export const PROFILE_IMAGE = vdoan;

export const SOCIAL_LINKS = [
    {
        type: 'linkedIn',
        label: 'linkedIn/vdoan',
        link: 'www.linkedin.com/in/vdoan89',
        icon: SOCIAL + '/SOCIAL/linkedin.svg'
    },
    {
        type: "github",
        label: "github/vdoan",
        link: "https://github.com/vdoan-gmuEWF",
        icon: SOCIAL + '/SOCIAL/github.svg'
    },
    {
        type: "trailhead",
        label: "trailhead/vdoan",
        link: "https://trailblazer.me/id/vdoan",
        icon: SOCIAL + '/SOCIAL/trailhead.svg'
    }
]

export const USER_DETAILS = {
    NAME: 'Vu T. Doan',
    ROLE: 'Full Stack Developer',
    EMAIL: 'doan_vu@bah.com',
    PHONE: '+1 571-346-5928'
}

export const CAREER_SUMMARY={
    HEADING:"CAREER SUMMARY",
    DESCRIPTION: "Versatile and highly skilled Computer Science professional with a strong academic background and extensive experience in software development and workflow optimization. Proficient in a wide range of programming languages and technologies, with a proven track record of leading teams and implementing innovative solutions to enhance application performance and user experience. Possesses a solid foundation in areas such as Analysis of Algorithms, Software Engineering, Visual Computing, and Artificial Intelligence. Recognized for exceptional problem-solving abilities, effective communication, and dedication to achieving project goals. Eager to leverage expertise and continue making impactful contributions in the field of computer science.",
    KEYS_POINTS:[
        "Advanced Workflow Development",
        "Front-end Development and User Experience Enhancement:. ",
        "API Development and Integration.",
        "Diverse Skill Set and Technologies. ",
    ]
}

export const EXPERIENCE_DATA={
    HEADING: "Work Experience",
    EXPERIENCES: [
        {
            ROLE: "Software Developer - Software Sustainment, Consultant",
            COMPANY_NAME: "Booz Allen Hamilton Inc.",
            DURATION: "Jan 2023 - Present",
            DESCRIPTION:
                "Results-driven Salesforce Developer with expertise in Platform Development and JavaScript, aiming to leverage technical proficiency and problem-solving skills to contribute effectively to Salesforce projects. Collaborate with cross-functional teams and deliver innovative solutions that drive business growth and enhance user experience.",
            DESCRIPTION_POINTS: [
                "Develop custom Salesforce solutions using Apex, Visualforce, Lightning Components, and Lightning Web Components (LWC) to meet business requirements and enhance user experience",
                "Design and implement complex workflows, process builder flows, and validation rules to automate business processes and ensure data integrity",
                "Integrate external systems with Salesforce using REST/SOAP APIs, Platform Events, and Salesforce Connect to enable seamless data exchange",
                "Optimize Salesforce performance by analyzing and improving SOQL queries, Apex code, and configuration settings",
                "Collaborate with stakeholders to gather requirements, provide technical recommendations, and deliver high-quality solutions within project timelines",
                "Implemented continuous integration and deployment (CI/CD) processes using Salesforce DX, Git, and Jenkins for efficient development and deployment workflows"
            ],
            TECHNOLOGIES_USED: {
                HEADING: 'Technologies used',
                LIST: [
                    "Apex",
                    "Javascript",
                    "HTML5/CSS",
                    "SOQL/SOSL",
                    "Lightning Web Components (LWC)",
                    "Salesforce APIs (REST, SOAP)",
                    "Apex Triggers",
                    "Visualforce"
                ]
            },
        },
        {
            ROLE: "Lead Software & Workflow Developer / Analyst",
            COMPANY_NAME: "George Mason University",
            DURATION: "Sep 2020 – Jan 2023",
            DESCRIPTION:
                "Led in developing efficient workflows on Ellucian Workflow/Process Maker, integrated RESTful APIs via Ellucian Ethos using Object-Oriented PHP. Specialized in implementing high-performance solutions, including advanced caching strategies in Laravel with Redis, modern front-end development using HTML/CSS/JavaScript, and custom API development using Spring Boot with Java and ASP.NET with C#.",
            DESCRIPTION_POINTS: [
                "Team Lead in workflow developments on the Ellucian Workflow / Process Maker platform (running on Laravel 8.x)",
                "Integrateed RESTful APIs through Ellucian Ethos Integration using Object-Oriented PHP event triggers",
                "Implemented high-performance, asynchronous, non-blocking event-driven using ReactPHP to improve application responsiveness and scalability",
                "Implemented advanced caching strategies in Laravel using Redis as the cache store, significantly improving application performance and reducing database load",
                "Developed modern, user-friendly front-end using HTML, CSS, JavaScript, and jQuery",
                "Conducted thorough planning, wireframing, and implemented semantic HTML tags for optimal accessibility and SEO",
                "Leveraged jQuery to streamline development, incorporating animations, event handling, and DOM manipulation",
                "Integrated AJAX for asynchronous data fetching and ensured cross-browser compatibility",
                "Developed custom APIs using Spring Boot with Java and ASP.NET with C#",
                "Integrated with databases using Spring Data JPA and using Entity Framework to connect with SQL Server, MySQL and Oracle",
                "Utilized Spring Security for authentication and authorization, including JWT or OAuth, or using ASP.NET Identity",
                "Analyzeed and implemented Business Process Modeling workflows with Microservices integration (DocuSign, OCR, Canva)",
                "Worked with GraphQL for efficient data retrieval and manipulation, implementing schemas and queries/mutations",
                "Utilized tools like Jenkins and GitLab to streamline the software development process",
                "Implemented SOAP service endpoints, incorporate security measures (authentication, XML encryption) and data validation"
            ],
            TECHNOLOGIES_USED: {
                HEADING: 'Technologies used',
                LIST: [
                    "PL/SQL",
                    "C#",
                    "GraphQL",
                    "JSON",
                    "HTML5/CSS3",
                    "Java",
                    "JavaScript",
                    "PHP",
                    "ReactPHP"
                ]
            }
        },
        {
            ROLE: "Software Developer Intern",
            COMPANY_NAME: "Venio Systems, LLC",
            DURATION: "Feb 2020 – May 2020",
            DESCRIPTION:
                "Contributed to the advancement of Natural Language Processing models, including entity and language recognition, and text classification through the implementation of Latent Dirichlet Allocation (LDA).",
            DESCRIPTION_POINTS: [
                "Researched and developed the capabilities of Natural Language Processing models (Catalyst NLP)",
                "Created a proof of concept on how entity recognition, language recognition, text classification, and implemented Latent Dirichlet Allocation (LDA)",
                "Helped with maintaining web applications using Angular and React frameworks",
                "Collaborated with the development team to design and implement database solutions",
                "Leveraged PostgreSQL for structured data storage, schema design, and query optimization",
                "Collaborated with the development team to design and implement database solutions",
                "Assisted in integrating DynamoDB and MongoDB, a NoSQL database service and principles, for flexible and scalable data storage",
                "Assisted in managing PostgreSQL databases using PSQL, performing tasks such as schema creation and data querying",
                "Gained experience in designing and managing database schemas and performing efficient data operations",
                "Worked with Docker to containerize applications, enabling consistent deployment across different environments",
                "Contributed to the development and improvement of the CI/CD pipeline for automated builds and deployments",
                "Utilized tools like Jenkins and GitLab to streamline the software development process",
                "Gained knowledge of version control, continuous integration, and automated testing practices",
            ],
            TECHNOLOGIES_USED: {
                HEADING: 'Technologies used',
                LIST: [
                    "C#",
                    "Prisma",
                    "Javascript",
                    "Github",
                    "ReactJS",
                    "NextJS",
                    "Docker",
                    "AWS",
                    "TypeScript",
                    "AngularJS"
                ]
            }
        },
    ]
}

export const EDUCATION_DATA={
    ICON: SOCIAL + '/SOCIAL/education.svg',
    HEADING: "EDUCATION",
    LIST:[
        {
            NAME: "Ph.D in Computer science",
            UNIVERSITY_NAME: "George Mason University",
            DURATION: "2023 - Present",
        },
        {
            NAME: "Master in Software Engineering",
            UNIVERSITY_NAME: "George Mason University",
            DURATION: "2020 - 2023",
        }
        ,
        {
            NAME: "Bachelor in Information Technology",
            UNIVERSITY_NAME: "George Mason University",
            DURATION: "2018 - 2020",
        }
    ]
}

export const AWARDS_DATA={
    ICON: SOCIAL + '/SOCIAL/awards.svg',
    HEADING: "AWARDS",
    LIST: [
        {
            NAME: "ITS Value to the Core",
            DESCRIPTION:"Recipient of ITS Value to the Core Award at George Mason University, Januart 2023",
        }
    ]
}

export const CERTIFICATION_DATA={
   ICON: SOCIAL + '/SOCIAL/certification.svg',
   HEADING: "CERTIFICATIONS",
   LIST: [
       {
           NAME: "Salesforce JavaScript Dev 1",
       },
       {
           NAME: "Salesforce Platform Dev 1",
       }
   ]
}

export const LANGUAGES_DATA={
   HEADING: "Languages",
   LIST: [
       {
           NAME: "Vietnamese",
           LEVEL: "Native",
       },
       {
           NAME: "English",
           LEVEL: "Professional",
       }
   ]
}

export const SKILLS_DATA ={
   HEADING: "SKILLS & TOOLS",
   SKILLS:[
       {
           HEADING: "FRONTEND",
           SKILLS_LIST: [
               { NAME: "Laravel", LEVEL: "95" },
               { NAME: "Angular", LEVEL: "80" },
               { NAME: "React", LEVEL: "75" },
               { NAME: "JavaScript(ES5/ES6/ES7/ES8)", LEVEL: "89" },
               { NAME: "HTML5/CSS3/SASS/LESS", LEVEL: "90" },
           ],
       },
       {
           HEADING: "BACKEND",
           SKILLS_LIST: [
               { NAME: "NodeJs", LEVEL: "80" },
               { NAME: "Java", LEVEL: "95" },
               { NAME: "PHP", LEVEL: "98" },
           ],
       },
       {
           HEADING: "CRM/CMS",
           SKILLS_LIST: [
               { NAME: "Salesforce", LEVEL: "70" },
               { NAME: "Ellucian", LEVEL: "90" },
               { NAME: "ProcessMaker", LEVEL: "90" },
           ],
       }
   ],
   OTHERS_SKILLS:{
       HEADING: 'OTHERS',
       SKILLS_LIST: [
           "C#",
           "JavaScript",
           "PL/SQL",
           "JSON",
           "GraphQL",
           "ngnix",
           "TypeScript",
           "Git",
           "AWS",
           "PostgreSQL",
           "Docker",
           "Apache Kafka",
           "Postman",
           "Insomnia"
        ]
   }
}

export const INTERESTS_DATA = {
   HEADING: "Interests",
   LIST: ["Fitness", "Video Games"]
}