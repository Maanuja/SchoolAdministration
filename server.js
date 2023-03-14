import { graphqlHTTP } from 'express-graphql';
import { graphql, buildSchema } from 'graphql';
import express from 'express';

import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

let app = express();

// Construct a schema, using GraphQL schema language
let schema = buildSchema(`
    type Students {
        student_id: Int!
        first_name: String!
        last_name: String!
        gender: gender!
        class_id: Int!
        email: String!
        class: Classes
        grades: [Grades]
    }

    input StudentInput {
        first_name: String!
        last_name: String!
        gender: gender!
        class_id: Int!
        email: String!
    }

    type Classes {
        class_id: Int!
        class_name: String!
        courses: [Courses]
        students: [Students]
    }

    type Courses {
        course_id: Int!
        course_name: String!
        teacher_id: Int!
        class_id: Int!
        teacher: Teachers
        class: Classes
        grades: [Grades]
    }

    input CourseInput {
        course_name: String!
        teacher_id: Int!
        class_id: Int!
    }
    
    type Teachers {
        teacher_id: Int!
        first_name: String!
        last_name: String!
        gender: gender!
        email: String!
        courses: [Courses]
    }

    input TeacherInput {
        first_name: String!
        last_name: String!
        gender: gender!
        email: String!
    }

    type Grades {
        student_id: Int!
        course_id: Int!
        grade: Int
        student: Students
        course: Courses
    }

    input GradeInput {
        student_id: Int!
        course_id: Int!
        grade: Int
    }

    input GradeIdInput {
        student_id: Int!
        course_id: Int!
    } 

    enum gender {
        F
        M
    }

    type Query {
        students: [Students]
        student(id: Int!): Students

        teachers: [Teachers]
        teacher(id: Int!): Teachers
        
        classes: [Classes]
        classe(id: Int!): Classes

        courses: [Courses]
        course(id: Int!): Courses

        grades: [Grades]
        grade(id: Int!): Grades
    }

    type Mutation {
        createOrUpdateStudent(data: StudentInput!): Students
        deleteStudent(id: Int!): Students

        createOrUpdateClasse(class_name: String!): Classes
        deleteClasse(id: Int!): Boolean

        createOrUpdateTeacher(data: TeacherInput!): Teachers
        deleteTeacher(id: Int!): Boolean
    
        createCourse(data: CourseInput!): Courses
        updateCourse(id: Int!, data: CourseInput!): Courses
        deleteCourse(id: Int!): Boolean
    
        createOrUpdateGrade(data: GradeInput!): Grades
        deleteGrade(data: GradeIdInput!): Boolean
    }
`);


// The rootValue provides a resolver function for each API endpoint
var resolvers = {
        students: async () => {
          return await prisma.students.findMany();
        },
        student: async ({ id }) => {
            return await prisma.students.findFirst({ 
                where: { 
                    student_id: id 
                } 
            });
        },
        createOrUpdateStudent: async ({ data }) => {
            const student = await prisma.students.findFirst({
                where: { email : data.email }
            })
            if (student) return await prisma.students.update({ 
                where: { 
                    student_id: student.student_id, 
                },
                data
            });
            return await prisma.students.create({ data });
        },
        deleteStudent: async ({ id }) => {
            try {
                const deleteStudent = await prisma.students.delete({ 
                    where: { 
                        student_id: id 
                    } 
                })
                return true
            } catch (error) {
                return false
            }
        },

        classes: async () => {
            return await prisma.classes.findMany();
        },
        classe: async ({ id }) => {
            return await prisma.classes.findFirst({
                where: { 
                    class_id: id 
                } 
            });
        },
        createOrUpdateClasse: async  ({ class_name }) => {
            const classe = await prisma.classes.findFirst({
                where: {
                     class_name : class_name,
                }
            })
            if (classe){
                return await prisma.classes.update({
                    where: { 
                        class_id : classe.class_id,
                    }, 
                    data: { 
                        class_name : class_name 
                    }
                });
            }
    
            return await prisma.classes.create({ class_name });
        },
        deleteClasse: async ({ id }) => {
            return  await prisma.classes.delete({ where: {class_id : id } });
        },

        courses: async () => {  
            return await prisma.courses.findMany();
        },
        course: async ({id}) => {
            return await prisma.courses.findFirst({
                where: {
                    course_id : id
                }
            })
        }, 
        createCourse: async ({ data }) => {
            return await prisma.courses.create({ data });
        },
        updateCourse: async ({ id , data }) => {
            return await prisma.courses.update({ 
                where: { 
                    course_id : id 
                },
                data
            });
        },
        deleteCourse: async ({ id }) => {
            try {
                const deleteCourse = await prisma.courses.delete({ 
                    where: {
                        course_id : id
                    }
                })
                return true
            } catch (error) {
                return false
            }
        },

        teachers: async () => {
            return await prisma.teachers.findMany();
        },
        teacher: async ({id }) => {
            return await prisma.teachers.findFirst({
                where: {
                    teacher_id: id
                }
            });
        },
        createOrUpdateTeacher: async ({id, data }) => {
            const { last_name, first_name, gender, email} = data;
            const teacher = await prisma.teachers.findFirst({
                where: {
                    email : email,
                }
            });

            if (teacher) {
                return await prisma.teachers.update({
                    where: {
                        teacher_id: teacher.teacher_id,
                    },
                    data
                });
            }
            return await prisma.teachers.create({ data });
        },
        deleteTeacher: async ({ id }) => {
            try {
                const deleteTeacher = await prisma.teachers.delete({
                    where: {
                        teacher_id: id,
                    }
                })
                return true
            } catch (error) {
                return  false
            }
        },

        grades: async () => {
            return await prisma.grades.findMany();
        },
        grade: async ({id}) => {
            return await prisma.grades.findFirst({
                where: {
                    grade_id: id,
                }
            });
        },
        createOrUpdateGrade: async ( {data}) => {
            try {
                const { student_id, course_id , grade } = data;
                // Check if the student and course exist
                const student = await prisma.students.findFirst({
                    where: { student_id: student_id },
                })
                if (!student) throw new Error(`No student found with id ${student_id}`);
                
                const course = await prisma.courses.findFirst({
                    where: { course_id: course_id },
                })
                if (!course) throw new Error(`No course found with id ${course_id}`);
        
                // Check if the student is enrolled in the course
                const enrollment = await prisma.courses.findFirst({
                    where: {course_id : course_id, class_id : student.class_id ,},
                })

                if (!enrollment) {
                    throw new Error(`Student ${student_id} is not enrolled in course ${course_id}`);
                } else {
                    const getGrade = await prisma.grades.findFirst({ where : {student_id : student_id, course_id: course_id} });
                    if (getGrade) {
                        // Update the grade
                        console.log(`Grade updated for student ${student_id} in course ${course_id} to ${grade}`)
                        return await prisma.grades.update({
                            where: {
                                student_id_course_id : { 
                                    student_id: student_id,
                                    course_id: course_id,
                                }
                            },
                            data: {
                                grade : grade
                            }
                        });
                    }
                }
                console.log(`Grade create for student ${student_id} in course ${course_id} to ${grade}`)
                return await prisma.grades.create({ data });
              } catch (err) {
                console.error(err)
              }
        },
        deleteGrade: async ({ data }) => {
            const { student_id, course_id } = data;
            try {
                const deleteGrade = await prisma.grades.delete({
                    where: {
                        student_id_course_id:  { student_id: student_id, course_id: course_id },
                    }
                })
                return true
              } catch (error) {
                console.error(error)
                return false
              }
        }
};



    
//Set up pour lancer le server
app.use('/schooladministration', graphqlHTTP({
    schema: schema,
    rootValue: resolvers,
    graphiql: true,
  }));
  app.listen('3456');
  console.log('Running a GraphQL API server at http://localhost:3456/schooladministration');