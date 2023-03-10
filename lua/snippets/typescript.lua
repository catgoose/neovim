local ls = require("luasnip")
local s, t, i, c, r, f, sn =
	ls.snippet, ls.text_node, ls.insert_node, ls.choice_node, ls.restore_node, ls.function_node, ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local u = require("util.luasnip")
local smn = u.same_node

local snippets = {
	s(
		"same",
		fmt(
			[[
  same 1 {}
  same 2 {}
  ]],
			{
				i(1),
				smn(1),
			}
		)
	),
	s(
		"cl",
		c(1, {
			fmt(
				[[
      console.log({});
      ]],
				r(1, "console_log")
			),
			fmt(
				[[
console.group('{}');
console.log({});
console.groupEnd();
  ]],
				{ i(1), r(2, "console_log") }
			),
		})
	),
	s(
		"cyg",
		fmt([[cy.get({}).{}]], { c(1, {
			fmt([['[data-test={}]']], i(1)),
			t(""),
		}), i(2) })
	),
	s("exp", fmt("expect({}).{}", { i(1), i(2) })),
	s(
		"de",
		fmta(
			[[describe('<>', () =>> {
   <> 
  });]],
			{ i(1), i(2) }
		)
	),
	s(
		"nspy",
		fmt([[const {} = jest.spyOn({}, '{}');]], {
			i(1, "spy"),
			i(2, "service"),
			i(3, "method"),
		})
	),
	s(
		"expspy",
		fmt(
			[[
expect({}).toHaveBeenCalled();
  ]],
			i(1, "spy")
		)
	),
	s(
		"it",
		fmta(
			[[it('<>', <>() =>> {
    <>
  })]],
			{
				i(1),
				c(2, {
					t(" "),
					t("async"),
				}),
				i(3),
			}
		)
	),
	s(
		"be",
		fmta(
			[[
      beforeEach(<> () =>> {
  <>
})
  ]],
			{ c(1, {
				t(" "),
				t("async"),
			}), i(2) }
		)
	),
	s(
		"nlogger",
		fmta(
			[[
      #<>(message: any, ...args: any) {
      this.logger.<>(message, { context: <>.name, ...args, });
      }
      ]],
			{
				c(1, {
					t("error"),
					t("warn"),
					t("debug"),
				}),
				smn(1),
				f(u.nest_classname),
			}
		)
	),
	s(
		"ntry",
		fmta(
			[[const args = {<>}
     try {
       <>
      } catch (error) {
        this.#error(error, { function: '<>', args });
      };
    ]],
			{ i(1), i(2), i(3, "MethodName") }
		)
	),
	s(
		"con",
		fmta(
			[[
  constructor(<>) {<>}
  ]],
			{ i(1), i(0) }
		)
	),
	s(
		"inj",
		fmt([[{}{}: {}]], {
			c(1, {
				t("private "),
				t("public "),
				t(""),
			}),
			i(2, "service"),
			u.capitalize(2),
		})
	),
	s("angenv", t([[import { environment } from 'src/environments/environment';]])),
	s(
		"tbi",
		fmt(
			[[
  {} = TestBed.inject({});
  ]],
			{ i(1), i(2) }
		)
	),
	s(
		"get",
		fmta(
			[[get <>() {
    return this.<>; 
  }]],
			{ i(1), i(2) }
		)
	),
	s(
		"set",
		fmta(
			[[set <>(<>) {
  this.<> = <>;
}]],
			{ i(1), i(2), i(3), i(4) }
		)
	),
	s("onpush", t([[changeDetection: ChangeDetectionStrategy.OnPush,]])),
	s("change", t([[changeDetection: ChangeDetectionStrategy.OnPush,]])),
	s(
		"ncon",
		fmta(
			[[
  constructor(private logger: WinstonLoggerService) { }
  #error(error: any, ...args: any) {
    this.logger.error(error, {
      context: <>.name,
      ...args,
    });
  }
  ]],
			f(u.nest_classname)
		)
	),
	s(
		"entity",
		fmta(
			[[
import { GraphUserEntity } from "@app/graph-user";
import {
  Entity,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  VersionColumn,
  ManyToOne,
} from "typeorm";

@Entity({
  name: "<>",
  schema: "<>",
})
export class <>Entity {
  @PrimaryGeneratedColumn()
  id: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @VersionColumn()
  version: number;

  @ManyToOne(() =>> GraphUserEntity, (user) =>> user.id)
  createdByUser: GraphUserEntity;

  @ManyToOne(() =>> GraphUserEntity, (user) =>> user.id)
  updatedByUser: GraphUserEntity;
}
  ]],
			{ i(1, "table"), i(2, "schema"), i(3, "") }
		)
	),
	s(
		"ncol",
		fmt(
			[[
  @Column({})
  {}: {}
  ]],
			{
				c(1, {
					t(""),
					t({
						"{",
						[[type: "simple-json"]],
						"}",
					}),
				}),
				i(2, "name"),
				i(3, "Type"),
			}
		)
	),
	s(
		"injrepo",
		fmt(
			[[
  @InjectRepository({}, '{}')
  private {}Repo: Repository<{}>
  ]],
			{
				i(1),
				i(2, "datasource"),
				i(3),
				smn(1),
			}
		)
	),
	s(
		"injdatasource",
		fmt(
			[[
    @InjectDataSource("{}")
    private entityManager: Entitymanager
    ]],
			i(1, "datasource")
		)
	),
	s(
		"injds",
		fmt(
			[[
    @InjectDataSource("{}")
    private entityManager: Entitymanager
    ]],
			i(1, "datasource")
		)
	),
	s(
		"httpexc",
		fmt(
			[[
      const error = `{}`;
	       throw new HttpException(
         {{
	           status: HttpStatus.{},
	           error,
	         }},
	         HttpStatus.{}
	       );
	 ]],
			{
				i(1),
				c(2, {
					t("BAD_REQUEST"),
					t("UNAUTHORIZED"),
					t("FORBIDDEN"),
					t("NOT_FOUND"),
					t("METHOD_NOT_ALLOWED"),
					t("NOT_ACCEPTABLE"),
				}),
				smn(2),
			}
		)
	),
	s(
		"#httpexc",
		fmta(
			[[
  #httpException(error: any, ...args: any) {
    throw new HttpException(
      {
        status: HttpStatus.BAD_REQUEST,
        error: args ? `${error} - ${args}` : error,
      },
      HttpStatus.BAD_REQUEST
    );
  }
	 ]],
			{}
		)
	),
	s(
		"nmeth",
		fmta(
			[[
  <><>(<>) {
      const args = { <> }
    try {
      <>
    } catch (error) {
      this.#error(error, { method: this.<>.name, args});
      throw error;
    }
  }
  ]],
			{
				c(1, {
					t("async "),
					t(""),
				}),
				i(2, "method"),
				i(3),
				f(u.nest_method_args, { 3 }),
				i(0),
				smn(2),
			}
		)
	),
	s(
		"datasource",
		fmt(
			[[
    @InjectDataSource("{}")
    private entityManager: EntityManager,
  ]],
			{ i(1) }
		)
	),
	s("#destroy", {
		t([[#destroy = new Subject<void>();]]),
	}),
	s("ondestroy", {
		sn(nil, {
			t({
				"ngOnDestroy(): void {",
				"\tthis.#destroy.next();",
				"}",
			}),
		}),
	}),
	s(
		"deb",
		fmta(
			[[
    this.#debug(<>, {
      <>
    })
    ]],
			{
				c(1, {
					fmt([[`{}`]], i(1)),
					fmta(
						[[
  `<>: ${<>}`
  ]],
						{ smn(1), i(1) }
					),
					fmt([[{}]], i(1)),
				}),
				c(2, {
					t(""),
					fmta(
						[[
            method: this.<>.name,
            args
          ]],
						{ i(1) }
					),
				}),
			}
		)
	),
	s(
		"store",
		fmta(
			[[
import { Injectable } from "@angular/core";
import { ComponentStore } from "@ngrx/component-store";

type <>State = {
  state: string
};

@Injectable()
export class <>Store extends ComponentStore<<<>State>> {
  constructor() {
    super({
      state: "initial",
    })
  }
}
    ]],
			{
				i(1, "StoreName"),
				smn(1),
				smn(1),
			}
		)
	),
	s(
		"cachemodule",
		fmta(
			[[
    CacheModule.register({
      isGlobal: <>,
      ttl: <>,
    }),
    ]],
			{ i(1, "true"), i(2, "60 * 24") }
		)
	),
	s("cacheimport", t([[import { Cache } from "cache-manager";]])),
	s("cache", {
		t([[@Inject(CACHE_MANAGER) private cacheManager: Cache]]),
	}),
	s("nhttpimport", t([[import { HttpService } from "@nestjs/axios";]])),
	s("schedule", t([[ScheduleModule.forRoot(),]])),
	s(
		"appenv",
		fmta(
			[[
import { Environment } from './environment.type';

export class AppEnvironment {
  environment = baseEnvironment;
  constructor(environment: DeepPartial<<Environment>> = {}) {
    this.environment = this.#extendEnvironment(environment);
  }
  #extendEnvironment(environment: DeepPartial<<Environment>>): Environment {
    return Object.assign({}, baseEnvironment, environment);
  }
}

type DeepPartial<<T>> = T extends object
  ? {
      [P in keyof T]?: DeepPartial<<T[P]>>;
    }
  : T;

  const baseEnvironment: Environment = {

  }
      ]],
			{}
		)
	),
	s(
		"newappenv",
		fmta(
			[[
import { AppEnvironment } from './environment.app';

export const environment = new AppEnvironment().environment;
  ]],
			{}
		)
	),
	s("tap", {
		t("tap((val) => console.log(val))"),
	}),
	s("catchError", {
		fmta(
			[[
catchError((err) =>> {
  this.snackbarService.error(
    `<>: ${err.message}`
  );
  return throwError(err);
})
]],
			{ i(1) }
		),
	}),
	s(
		"stand",
		fmt(
			[[
  standalone: true,
  imports: [CommonModule, {}],
  ]],
			{ i(1) }
		)
	),
}

return snippets
