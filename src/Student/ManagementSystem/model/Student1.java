package Student.ManagementSystem.model;

import Student.ManagementSystem.vo.StudentVO;

public interface Student1 {
    /**
     * 학생의 총점을 계산한다.
     * 국어,영어,수학,과학 점수를 합산하여 총점을 계산한다.
     *
//     * @param studentVO 총점을 계산할 학생 객체
     */
    void total(StudentVO vo);

    /**
     * 학생의 평균 점수를 계산한다.
     * 총점을 과목수로 나누어 평균값을 계산한다.
//     * @param studentVO 평균 점수를 계산할 학생 객체
     * */
    void average(StudentVO vo);

    /**
     * 학생의 등급을 결정한다.
     *
     * - 90점 이상 : A
     * - 80점 이상 : B
     * - 70점 이상 : C
     * - 60점 이상 : D
     * - 60점 미만 : F
     *
//     * @param studentVO 등급을 계산할 학생 객체
     * */
    void grade(StudentVO vo);


    /**
     * 새로운 데이터를 입력하는 메서드
     *
//     * @param StudentVO 입력할 데이터의 정보
     */
    void input(StudentVO student);

    void delete(StudentVO student);

    void update(StudentVO student);

    void totalSearch(int sortNum);

    void search(String searchNum);

    void sort(int sortNum);
}