//
//  main.swift
//  MyCreditManager
//
//  Created by 안윤철 on 2022/11/21.
//

import Foundation

class Classroom {
    static var students = [Student]()
    
    static func addStudent() {
        
        let inputName = readLine() ?? ""
        
        if inputName == "" {
            
            print("잘못 입력 되었습니다.")
            printMenu()
            
            return
        }
        
        for student in students {
            if student.name == inputName {
                print(inputName + "은 이미 존재하는 학생입니다. 추가하지 않습니다.")
                printMenu()
                
                return
            }
        }
        
        students.append(Student(name: inputName))
        print(inputName + " 학생을 추가했습니다.")
        printMenu()
    }
    
    static func deleteStudent() {
        
        let inputName = readLine() ?? ""
        
        if inputName == "" {
            
            print("잘못 입력 되었습니다.")
            printMenu()
            return
        }
        
        var check = false
        for student in students {
            if student.name == inputName {
                check = true
            }
        }
        
        if check == false {
            
            print(inputName + "학생을 찾지 못했습니다.")
            printMenu()
            return
        } else {
            
            students = students.filter() {$0.name != inputName}
            
            print(inputName + " 학생을 삭제하였습니다.")
            printMenu()
        }
    }
    
    static func addScore() {
        // name, subject, score
        let input = readLine()!.split(separator: " ")
        
        if input.count != 3 {
            
            print("잘못 입력 되었습니다.")
            printMenu()
            return
        }
        
        var check = false
        for student in students {
            if student.name == input[0] {
                check = true
            }
        }
        
        if check == false {
            
            print(input[0] + "학생을 찾지 못했습니다.")
            printMenu()
            return
        } else {
            for (index, student) in students.enumerated() {
                if student.name == input[0] {
                    if ((students[index].subjects?.isEmpty) == nil) {
                        
                        students[index].subjects = [String(input[1]): String(input[2])]
                    } else {
                        
                        students[index].subjects?[String(input[1])] = String(input[2])
                    }
                }
            }
            
            print(students)
            printMenu()
        }
    }
    
    static func deleteScore() {
        let input = readLine()!.split(separator: " ")
        
        if input.count != 2 {
            print("잘못 입력 되었습니다. 다시 확인해주세요.")
        }
        
        var check = false
        for student in students {
            if student.name == input[0] {
                
                check = true
            }
        }
        
        if check == false {
            
            print(input[0] + "학생을 찾지 못했습니다.")
            printMenu()
            
            return
        } else {
            for (index, student) in students.enumerated() {
                if student.name == input[0] {
                    students[index].subjects?.removeValue(forKey: String(input[1]))
                    
                    if students[index].subjects?.count == 0 {
                        students[index].subjects = nil
                    }
                }
            }
            printMenu()
        }
    }
    
    static func showScore() {
        let inputName = readLine() ?? ""
        
        if inputName == "" {
            
            print("잘못 입력 되었습니다.")
            return
        }
        
        var check = false
        for student in students {
            if student.name == inputName {
                
                check = true
            }
        }
        
        if check == false {
            
            print(inputName + "학생을 찾지 못했습니다.")
            printMenu()
            return
        } else {
            var totalScore: Double = 0.0
            var subjectNumber: Double = 0.0
            for student in students {
                if student.name == inputName {
                    
                    let subjectToScore = student.subjects!
                    for (subject, score) in subjectToScore {
                        print(subject + " : " + score)
                        
                        switch score {
                        case "A+":
                            totalScore += 4.5
                        case "A":
                            totalScore += 4.0
                        case "B+":
                            totalScore += 3.5
                        case "B":
                            totalScore += 3.0
                        case "C+":
                            totalScore += 2.5
                        case "C":
                            totalScore += 2.0
                        case "D+":
                            totalScore += 1.5
                        case "D":
                            totalScore += 1.0
                        case "F":
                            totalScore += 0.0
                        default:
                            break
                        }
                        subjectNumber += 1.0
                    }
                    print("평점 : " + String(totalScore / subjectNumber))
                }
            }
            printMenu()
        }
    }
}

struct Student {
    var name: String
    var subjects: [String: String]?
    var averageScore: Double?
}

var input = ""
var exit = false

func printMenu() {
    
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
}

printMenu()

while !exit {
    input = readLine() ?? ""
    
    switch input {
    case "1":   // 학생 추가
        print("추가할 학생의 이름을 입력해주세요.")
        Classroom.addStudent()
    case "2":   // 학생 삭제
        print("삭제할 학생의 이름을 입력해주세요.")
        Classroom.deleteStudent()
    case "3":
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        Classroom.addScore()
    case "4":
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        Classroom.deleteScore()
    case "5":
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        Classroom.showScore()
    case "X":
        print("프로그램을 종료합니다...")
        exit = true
    default:
        print("입력이 잘못 되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        printMenu()
    }
}
