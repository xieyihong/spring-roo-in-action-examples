// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.rooinaction.coursemanager.domain;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.rooinaction.coursemanager.domain.Student;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Student_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager Student.entityManager;
    
    public static final EntityManager Student.entityManager() {
        EntityManager em = new Student().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Student.countStudents() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Student o", Long.class).getSingleResult();
    }
    
    public static List<Student> Student.findAllStudents() {
        return entityManager().createQuery("SELECT o FROM Student o", Student.class).getResultList();
    }
    
    public static Student Student.findStudent(Long id) {
        if (id == null) return null;
        return entityManager().find(Student.class, id);
    }
    
    public static List<Student> Student.findStudentEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Student o", Student.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void Student.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Student.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Student attached = Student.findStudent(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Student.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Student.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public Student Student.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Student merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
