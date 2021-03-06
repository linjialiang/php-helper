# Git 合并

> 使用 Git 我们至少需要使用 `git merge` 合并工具！

## 与“分支|标签”间的合并

> 指令： `git merge <branch|tag>...`
>
> - 一次可以合并多个标签和分支
> - 只能对当前分支执行合并操作

```shell
$ git checkout dev1
Switched to branch 'dev1'
```

```shell
$ git merge v1.0.0
Updating aa90fbc..4b6aaaf
Fast-forward
 Git Basics/1.10-Git 合并.md | 8 ++++++++
 1 file changed, 8 insertions(+)
```

## 如果合并时出现冲突，就需要我们手动处理

```shell
$ git pull
Auto-merging Git Basics/1.10-Git 合并.md
CONFLICT (content): Merge conflict in Git Basics/1.10-Git 合并.md
Automatic merge failed; fix conflicts and then commit the result.
```

> 打开需要处理的文件：

```shell
zhizu@DESKTOP-SJ57HOL MINGW64 /d/git/Git Basics (dev1|MERGING)
$ vim 1.10-Git\ 合并.md
```

> 合并冲突的内容显示结果，并且我们对它进行编辑：

```shell
<<<<<<< HEAD
这段话是 master 上增加的
=======

这段好是 dev1 上增加的
>>>>>>> eed9062e1ac6dbd7e47d35636bd67a1c517b9f0c
```

> 处理完文件后，使用 `git add` `git commit` 进行提交操作
