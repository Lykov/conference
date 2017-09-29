// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.dw.roo.conference.domain;

import com.dw.roo.conference.domain.Speaker;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Speaker_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager Speaker.entityManager;
    
    public static final List<String> Speaker.fieldNames4OrderClauseFilter = java.util.Arrays.asList("firstname", "lastname", "email", "organization", "birthdate", "age", "talks");
    
    public static final EntityManager Speaker.entityManager() {
        EntityManager em = new Speaker().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Speaker.countSpeakers() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Speaker o", Long.class).getSingleResult();
    }
    
    public static List<Speaker> Speaker.findAllSpeakers() {
        return entityManager().createQuery("SELECT o FROM Speaker o", Speaker.class).getResultList();
    }
    
    public static List<Speaker> Speaker.findAllSpeakers(String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM Speaker o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, Speaker.class).getResultList();
    }
    
    public static Speaker Speaker.findSpeaker(Long id) {
        if (id == null) return null;
        return entityManager().find(Speaker.class, id);
    }
    
    public static List<Speaker> Speaker.findSpeakerEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Speaker o", Speaker.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    public static List<Speaker> Speaker.findSpeakerEntries(int firstResult, int maxResults, String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM Speaker o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, Speaker.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void Speaker.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Speaker.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Speaker attached = Speaker.findSpeaker(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Speaker.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Speaker.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public Speaker Speaker.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Speaker merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
