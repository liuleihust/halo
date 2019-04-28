package cc.ryanc.halo.model.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * <pre>
 *     文章分类
 * </pre>
 *
 * @author : RYAN0UP
 * @date : 2017/11/30
 */
// 注解在类上, 为类提供读写属性 get set 方法, 此外还提供了 equals()、hashCode()、toString() 方法
@Data
@Entity  // jpa 新建的定义，将常规的普通java 对象映射到数据库。创建一个Entity Bean 对象相当于新建一条记录，删除一个Entity Bean 对象相当于删除一条对应的记录
@Table(name = "halo_category")  // 当实体类与其映射的数据库表名不同名时需要使用 @Table注解说明，该标注与 @Entity 注解并列使用，置于实体类声明语句之前，用户指定表名。@Table注解还有两个选项 catalog 和 schema 用于设置表所属的数据库目录或模式，通常为数据库名
public class Category implements Serializable {

    private static final long serialVersionUID = 8383678847517271505L;

    /**
     * 分类编号
     */
    @Id
    @GeneratedValue
    private Long cateId;

    /**
     * 分类名称 页面上所显示的名称
     */
    @NotBlank(message = "分类名称不能为空")
    private String cateName;

    /**
     * 分类路径 这是文章路径上显示的名称
     */
    @NotBlank(message = "分类路径不能为空")
    private String cateUrl;

    /**
     * 分类描述 添加描述，部分主题可显示
     */
    private String cateDesc;

    @ManyToMany(mappedBy = "categories")
    @JsonIgnore
    private List<Post> posts = new ArrayList<>();
}
